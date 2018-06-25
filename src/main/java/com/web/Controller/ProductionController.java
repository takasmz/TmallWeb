package com.web.controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.web.Enums.StatusEnum;
import com.web.config.CommonUtil;
import com.web.pojo.BuyCartBean;
import com.web.pojo.ClientBean;
import com.web.pojo.OrderBean;
import com.web.pojo.ProductionBean;
import com.web.pojo.PropertyBean;
import com.web.pojo.ReviewBean;
import com.web.pojo.TypeBean;
import com.web.pojo.UserBean;
import com.web.redis.OrderRedisImpl;
import com.web.redis.RedisBaise;
import com.web.service.BuyCartService;
import com.web.service.ClientService;
import com.web.service.OrderService;
import com.web.service.ProductionService;
import com.web.service.ReviewService;
import com.web.service.TypeService;
import com.web.service.UserService;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
public class ProductionController {
	
	private static Logger logger = LoggerFactory.getLogger(ProductionController.class);
	
	@Autowired
	private ProductionService productionservice;
	
	@Autowired
	private OrderService orderservice;
	
	@Autowired
	private UserService userservice;
	
	@Autowired
	private TypeService typeservice;
	
	@Autowired
	private BuyCartService buycartservice;
	
	@Autowired
	private ReviewService reviewservice;
	
	@Resource(name="ClientRedisImpl")
    private RedisBaise<?, String, ?> ClientRedisImpl;
    
	@Resource(name="OrderRedisImpl")
    private RedisBaise<String, String, OrderBean> OrderRedisImpl;
	 
	/**
	 * 跳转主页面
	 * @param session
	 * @return
	 */
	@RequestMapping("/tmall")
	public ModelAndView tmallPage(HttpSession session){ 
		ModelAndView model = new ModelAndView("tmall");
		int buycartcount = 0;
		if(session.getAttribute("username")!=null){
			int id = userservice.getUserByUsername((String) session.getAttribute("username")).getId();
			buycartcount = buycartservice.getBuyCartCount(id);
		}
		session.setAttribute("buycartcount", buycartcount);
		List<TypeBean> typelist = typeservice.gettids(0);
		for(TypeBean type:typelist){
			//System.out.println(type.getName());
			type.setListproduction(productionservice.getProductionBytid(type.getId()));
		}
		model.addObject("typelist", typelist);
		return model;
	}
	
	/**
	 * 跳转商品大类页面
	 * @param tid
	 * @param session
	 * @return
	 */
	@RequestMapping("/forecategory")
	public ModelAndView forecategory(@RequestParam(value="tid")Integer tid,HttpSession session){
		ModelAndView model = new ModelAndView("/forecategory");
		String typename = typeservice.gettypebyid(tid).getName();
		List<ProductionBean> productionlist = productionservice.getProductionBytid(tid);
		for(ProductionBean production:productionlist){
			production.setReviewnumber(reviewservice.getAllReviewByproductionid(production.getId()).size());
		}   
		model.addObject("typename", typename);
		model.addObject("productionlist", productionlist);
		return model;
	}
	
	/**
	 * 跳转产品界面
	 * @param pid
	 * @param session
	 * @return
	 */
	@RequestMapping("/foreproduct")
	public ModelAndView foreproduct(@RequestParam(value="pid")Integer pid,HttpSession session){
		ModelAndView model = new ModelAndView("/foreproduct");
		ProductionBean production = productionservice.getProductionByid(pid);
		List<PropertyBean> listproper = productionservice.getPropertyBypid(pid);
		model.addObject("listproper", listproper);
		model.addObject("production", production);
		model.addObject("pid", pid);
		return model;
	}
	
	
	@RequestMapping("/reviewpage")
	public void reviewpage(@RequestParam(value="PageNum",defaultValue="1") Integer page,
			@RequestParam(value = "PageSize", defaultValue = "5") Integer PageSize,
			@RequestParam(value="pid")Integer pid,HttpSession session,HttpServletResponse response){
		JSONObject jsonObject = new JSONObject();
        JSONObject jo = new JSONObject();
        try {
        	JSONArray ja = new JSONArray();
        	PageHelper.startPage(page,5);
        	List<ReviewBean> listreview= reviewservice.getAllReviewByproductionid(pid);
        	PageInfo<ReviewBean> pageinfo = new PageInfo<ReviewBean>(listreview);
        	for(ReviewBean reviewbean:listreview) {
        		JSONObject jo1 = new JSONObject();
        		jo1.put("reviewbean",reviewbean);
        		ja.add(jo1);
        	}
        	jo.put("reviews", ja);
        	jo.put("count", reviewservice.getAllReviewByproductionid(pid).size());
        	jsonObject = CommonUtil.parseJson("1", "成功", jo);
    		session.setAttribute("pageInfo", pageinfo);
    		session.setAttribute("listreview", listreview); 
        }catch(Exception e){
        	jsonObject = CommonUtil.parseJson("2", "操作异常", "");
            logger.error(e.getMessage(), e);
        }
        CommonUtil.responseBuildJson(response, jsonObject);
		//JSONArray jsonArray = JSONArray.fromObject(listreview);
	}
	
	/**
	 * 跳转支付界面
	 * @param session
	 * @param request
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	@RequestMapping(value="/forebuy")
	public ModelAndView forebuy(HttpSession session, HttpServletRequest request) throws UnsupportedEncodingException{
		if(session.getAttribute("username")==null){
			return new ModelAndView("/login");
		}else{
			ModelAndView model = new ModelAndView("forebuy");
			int userid = (Integer) session.getAttribute("userid");
			String urlString = request.getQueryString();
			List<OrderBean> listorder = new ArrayList<OrderBean>();
			List<ProductionBean> productionlist = new ArrayList<ProductionBean>();
			int stock;
			double payment = 0;
			SimpleDateFormat df1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        	SimpleDateFormat df2 = new SimpleDateFormat("yyyyMMddHHmmss");
			String time = df1.format(new Date()); 
			ClientBean client = new ClientBean();
			client.setClient_id(df2.format(new Date())+userid); 
    		client.setTime(time);
    		client.setUser_id(userid);
    		client.setStatus(StatusEnum.waitPay);
    		Map<ProductionBean,Integer> productionmap = new HashMap<ProductionBean,Integer>();
			if(urlString.length()>20 && urlString.substring(0, 20).equals("productNumberSetting")){
				int pid = Integer.parseInt(request.getParameter("pid"));
				ProductionBean production = productionservice.getProductionByid(pid); 
				int productionNumber = Integer.parseInt(request.getParameter("productNumberSetting"));
				stock = production.getStock()-productionNumber;
				production.setStock(stock);
				production.setSales_volume(production.getSales_volume()+productionNumber);
				productionlist.add(production);
				OrderBean order = new OrderBean();
				double total = productionNumber * production.getPrice();
				order.setNumber(productionNumber);
				order.setProduction_id(production.getId());
				order.setUser_id(userid);
				order.setClient_id(client.getClient_id());
				payment = total;
				listorder.add(order);
				productionmap.put(production, productionNumber);
				model.addObject("productionmap", productionmap);
				client.setPayment(payment);
				model.addObject("clientid", client.getClient_id());
				productionservice.buyproduction(productionlist, client, listorder,null);
				return model;
			}else{
				List<BuyCartBean> buycartlist = new ArrayList<BuyCartBean>();
				for(String param:urlString.split("&")){
					Integer oiid = Integer.parseInt(param.substring(5));
					BuyCartBean buycart = buycartservice.getBuyCartByid(oiid);
					buycartlist.add(buycart);
					logger.debug(String.valueOf(buycart.getId()));
					ProductionBean production = productionservice.getProductionByid(buycart.getProduction_id());
					int productionNumber = buycart.getNumber();
					stock = production.getStock()-productionNumber;
					production.setStock(stock);
					production.setSales_volume(production.getSales_volume()+productionNumber);
					productionlist.add(production);
					OrderBean order = new OrderBean();
					double total = productionNumber * production.getPrice();
					order.setNumber(productionNumber);
					order.setProduction_id(production.getId());
					order.setUser_id(buycart.getUser_id());
					order.setClient_id(client.getClient_id());
					payment += total;
					listorder.add(order); 
					productionmap.put(production, productionNumber);
				}
				session.setAttribute("buycartcount", (int)session.getAttribute("buycartcount")-listorder.size()+1);
				client.setPayment(payment);
				productionservice.buyproduction(productionlist, client, listorder,buycartlist);
				model.addObject("clientid", client.getClient_id());
				model.addObject("productionmap", productionmap);
				return model;
			}
		}
	}
	
	 /**
	  * 更新购物车
	  * @param num
	  * @param pid
	  * @param session
	  * @return
	  */
	@RequestMapping(value="/updatebuycart")
	public ModelAndView updatebuycart(@RequestParam(value="num")Integer num,@RequestParam(value="pid") Integer pid,HttpSession session){
		if(session.getAttribute("username")==null){
			return new ModelAndView("login");
		 }else{
			 BuyCartBean buycart = buycartservice.getBuyCartByProductionid(pid);
			 buycart.setNumber(num);
			 buycart.setTotal(num*productionservice.getProductionByid(pid).getPrice());
			 buycartservice.updateBuyCart(buycart);
			 return new ModelAndView("forecart");
		 } 
		
	}
	 /**
	  * 删除购物车项
	  * @param oiid
	  * @param session
	  * @return
	  */
	@RequestMapping(value="/deletebuycart")
	public ModelAndView deletebuycart(@RequestParam(value="oiid") Integer oiid,HttpSession session){
		if(session.getAttribute("username")==null){
			return new ModelAndView("login");
		 }else{
			buycartservice.deleteBuyCart(oiid); 
			return new ModelAndView("forecart");
		 }
	}
	
	@RequestMapping(value="/search")
	public ModelAndView search(String keyword,HttpSession session) {
		ModelAndView model = new ModelAndView("foresearch");
		List<ProductionBean> searchlist = productionservice.getProductionByname(keyword);
		model.addObject("searchlist", searchlist);
		return model;
	}
	
	//springboot nginx mycat redis zookeeper
}
