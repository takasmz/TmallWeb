package com.web.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.web.config.CommonUtil;
import com.web.pojo.ProductionBean;
import com.web.pojo.ReviewBean;
import com.web.pojo.TypeBean;
import com.web.pojo.UserBean;
import com.web.service.ProductionService;
import com.web.service.TypeService;
import com.web.service.UserService;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/**
 * 管理类
 * @author lrh
 *
 */
@Controller
public class ManageController {
	
	Logger logger = LoggerFactory.getLogger(ManageController.class);
	
	@Autowired
	private ProductionService productionservice;
	
	@Autowired
	private UserService userservice;
	
	@Autowired
	private TypeService typeservice;
	
	/**
	 * 跳转管理界面
	 * @return
	 */
	@RequestMapping(value="/tomanage")
	public String tomanage() {
		return "manage";
		}
	
	/**
	 * 显示列表
	 * @param type
	 * @param page
	 * @param rows
	 * @param response
	 */
	@RequestMapping(value="/manage")
	public void manage(@RequestParam(value="type") String type,
						@RequestParam(value="PageNum") Integer page,
					   @RequestParam(value="PageSize") Integer rows,
					   HttpServletResponse response) {
		JSONObject jsonObject = new JSONObject();
		JSONObject jo = new JSONObject();
		System.out.println(type);
		try {
        	JSONArray ja = new JSONArray();
        	PageHelper.startPage(page,5);
        	List<?> objectlist;
        	int count;
        	switch(type) {
        		case("production"):{
        			objectlist = productionservice.getallproduction();
        			count = productionservice.getallproduction().size();
        			break;
        		}
        		case("type"):{
        			objectlist = typeservice.getalltype();
        			count = typeservice.getalltype().size();
        			break;
        		}
        		case("user"):{
        			objectlist = userservice.getalluser();
        			count = userservice.getalluser().size();
        			break;
        		}
        		default:{
        			objectlist = productionservice.getallproduction();
        			count = productionservice.getallproduction().size();
        			break;
        		}
        	}
        	//PageInfo<?> pageinfo = new PageInfo<>(objectlist);
        	for(Object object:objectlist) {
        		JSONObject jo1 = new JSONObject();
        		jo1.put("object",object);
        		ja.add(jo1);
        	}
        	jo.put("objects", ja);
        	jo.put("count", count);
        	jsonObject = CommonUtil.parseJson("1", "成功", jo);
        }catch(Exception e){
        	jsonObject = CommonUtil.parseJson("2", "操作异常", "");
            logger.error(e.getMessage(), e);
        }
        CommonUtil.responseBuildJson(response, jsonObject);
	}
	
	@RequestMapping(value="/upload",method = RequestMethod.POST)
	public ModelAndView upload(@RequestParam(value="oid")Integer oid,HttpServletRequest  request,MultipartFile file) throws IllegalStateException, IOException {
		//处理上传文件  
		System.out.println(request.getParameterMap().size());
		switch(request.getParameterMap().size()) {
		case(2):{
			TypeBean type = typeservice.gettypebyid(oid+1);
			type.setId(oid+1);
			type.setName((String)request.getParameter("name"));
			typeservice.updatetype(type);
			return new ModelAndView("redirect:tomanage");
		}
		case(5):{
			UserBean userbean = userservice.getUserById(oid+1);
			userbean.setMail((String)request.getParameter("mail"));
			userbean.setNickname((String)request.getParameter("nickname"));
			userbean.setUsername((String)request.getParameter("username"));
			userbean.setPassword((String)request.getParameter("password"));
			userservice.updateUser(userbean);
			return new ModelAndView("redirect:tomanage");
		}
		case(8):{
			ProductionBean productionbean = productionservice.getProductionByid(oid+1);
			String[] paths = productionbean.getImgpath().split("/");
			String basePath = "E:\\workspace\\TmallWeb\\src\\main\\webapp\\image" +"\\" +paths[1];
			String fileName = paths[paths.length-1]; 
			File dir = new File(basePath, fileName);
			if(!dir.exists()){  
	            dir.mkdirs();  
	        } 
			file.transferTo(dir);  
			//System.out.println(productionbean.getBrands());
			productionbean.setBrands((String)request.getParameter("brands"));
			productionbean.setModel((String)request.getParameter("model"));
			productionbean.setName((String)request.getParameter("name"));
			productionbean.setPrice(Double.parseDouble(request.getParameter("price")));
			productionbean.setStock(Integer.parseInt(request.getParameter("stock")));
			productionbean.setType_id(Integer.parseInt(request.getParameter("type_id")));
			productionservice.updateProduction(productionbean);
			return new ModelAndView("redirect:tomanage");
		}
		default:return new ModelAndView("redirect:tomanage");
		}	
	}
	
	@RequestMapping(value="/addpro")
	public ModelAndView addpro(MultipartFile file,HttpServletRequest request) throws IllegalStateException, IOException {
		String path = typeservice.gettypebyid(Integer.parseInt(request.getParameter("type_id"))).getPath();
		String basePath = "E:\\workspace\\TmallWeb\\src\\main\\webapp\\image" +"\\" + path;
		String fileName = file.getOriginalFilename();
		System.out.println(fileName);
		File dir = new File(basePath, fileName); 
		if(!dir.exists()){  
            dir.mkdirs();  
        } 
		file.transferTo(dir); 
		ProductionBean production = new ProductionBean();
		production.setType_id(Integer.parseInt(request.getParameter("type_id")));
		production.setName(request.getParameter("name"));
		production.setBrands(request.getParameter("brands"));
		production.setModel(request.getParameter("model"));
		production.setPrice(Integer.parseInt(request.getParameter("price")));
		production.setStock(Integer.parseInt(request.getParameter("stock")));
		production.setImgpath("image/"+path+"/"+fileName);
		production.setSales_volume(0);
		production.setReviewnumber(0);
		productionservice.insertProduction(production);
		return new ModelAndView("redirect:tomanage");	
	}
	
	@RequestMapping(value="/addtype")
	public ModelAndView addtype(@Valid TypeBean type) {
		typeservice.inserttype(type);
		return new ModelAndView("redirect:tomanage");
	}
	
	@RequestMapping(value="/adduser")
	public ModelAndView adduser(@Valid UserBean user) {
		userservice.insertUser(user); 
		return new ModelAndView("redirect:tomanage");
	}
	
	@RequestMapping(value="/delete")
	public void delete(@RequestParam(value="oid")Integer oid,@RequestParam(value="item") String item) {
		System.out.println(oid);
		switch(item) {
		case("production"):{
			productionservice.deleteProduction(oid);  
			break;
		}
		case("type"):{
			typeservice.deleteType(oid);
			break; 
		}
		case("user"):{
			userservice.deleteUser(oid);
			break;
		}
		default:break;
		}
	}
}
