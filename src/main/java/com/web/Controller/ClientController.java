package com.web.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.web.Enums.StatusEnum;
import com.web.pojo.BuyCartBean;
import com.web.pojo.ClientBean;
import com.web.pojo.OrderBean;
import com.web.pojo.ProductionBean;
import com.web.pojo.ReviewBean;
import com.web.pojo.UserBean;
import com.web.redis.RedisBaise;
import com.web.service.BuyCartService;
import com.web.service.ClientService;
import com.web.service.OrderService;
import com.web.service.ProductionService;
import com.web.service.ReviewService;
import com.web.service.UserService;

@Controller
public class ClientController {

	Logger logger = LoggerFactory.getLogger(ClientController.class);
	
	@Autowired
	private ClientService clientservice;
	
	@Autowired
	private UserService userservice;
	
	@Autowired
	private OrderService orderservice;
	
	@Autowired
	private ProductionService productionservice;
	
	@Autowired
	private BuyCartService buycartservice;
	
	@Autowired
	private ReviewService reviewservice;
	
	@SuppressWarnings("rawtypes")
	@Resource(name="ClientRedisImpl")
    private RedisBaise ClientRedisImpl;
    
    @SuppressWarnings("rawtypes")
	@Resource(name="OrderRedisImpl")
    private RedisBaise OrderRedisImpl;
	
    /**
     * 信息输入，跳转到支付页面
     * @param client
     * @param bindingResult
     * @param session
     * @return
     * @throws Exception
     */
	@RequestMapping("/forealipay")
	public ModelAndView forealipay(@Valid ClientBean client, BindingResult bindingResult,HttpServletRequest request) throws Exception {	    	
		 if(request.getSession().getAttribute("username")==null){
				return new ModelAndView("login");
			}else{
				ModelAndView model = new ModelAndView("/forebuy");
				//如果参数不对，就直接返回注册页面
		        List<FieldError> fieldErrors = bindingResult.getFieldErrors();
		        String error;
		        if (bindingResult.hasErrors()) {	        	
		        	for(FieldError fielderror:fieldErrors){		
		        		error = fielderror.getDefaultMessage();
		        		if(error.contains("姓名")){
		        			model.addObject("errorname",error);
		        		}else if(error.contains("手机")){
		        			model.addObject("errorphone",error);
		        		}else if(error.contains("地址")){
		        			model.addObject("erroraddress",error);
		        		}else if(error.contains("邮编")){
		        			model.addObject("errorpostal",error);
		        		}	
		        	}
		            return model;
		        }else{ 
		        	ModelAndView model1 = new ModelAndView("forealipay");
		        //对密码进行加密md5(密码+salt)后才存到数据库中
		       // orderservice.encryptedPassword(order);
		        	String clientid = request.getParameter("client_id");
		        	ClientBean realclient = clientservice.getClientByClientid(clientid);
		        	realclient.setAddress(client.getAddress());
		        	realclient.setPeoplename(client.getPeoplename());
		        	realclient.setPostal(client.getPostal());
		        	realclient.setPhone(client.getPhone());
		        	clientservice.updateClientInfo(realclient);
		        	logger.debug("总额"+realclient.getPayment());
		        	
		        	model1.addObject("client", realclient);
		        //提示用户发送了邮件，让用户激活账户
		       // String url = getProjectPath() + "/order/activate.do?orderId=" + order.getOrderId();
		       // emailService.sendEmail(order, "注册", url);
		        	return model1;
		        }
			} 
		 
	    }
	 
	 /**
	  * 正常支付
	  * @param session
	  * @return
	  */
	@RequestMapping("/forepayed")
	 public ModelAndView forepayed(HttpSession session,@RequestParam(value="cid") String client_id){
		 if(session.getAttribute("username")==null ){
				return new ModelAndView("login");
			}else{
				ModelAndView model = new ModelAndView("forepayed");
				ClientBean client = clientservice.getClientByClientid(client_id);
				client.setStatus(StatusEnum.waitDelivery);
				clientservice.updateClientStatus(client);
				model.addObject("total", client.getPayment());
				return model; 
			}
	 }
	 
	 /**
	  * 跳轉支付
	  * @param session
	  * @return
	  */
	 @RequestMapping(value="/turnforealipay")
	 public ModelAndView forealipay(@RequestParam(value="client_id") String client_id,HttpSession session){
		 if(session.getAttribute("username")==null ){
			return new ModelAndView("login");
		}else{
			ModelAndView model = new ModelAndView("forebuy");
			List<OrderBean> orderlist = orderservice.getAllOrderByclientid(client_id);
			Map<ProductionBean,Integer> productionmap = new HashMap<ProductionBean,Integer>();
			for(OrderBean order:orderlist) 
				productionmap.put(productionservice.getProductionByid(order.getProduction_id()), order.getNumber());	
			model.addObject("clientid", client_id);
			model.addObject("productionmap", productionmap);
			return model;
		}
	 }
	 
	 /**
	  * 取消支付
	  * @param session
	  * @return
	  */
	 @RequestMapping("/forepayexit")
	 public ModelAndView forepayexit(HttpSession session){
		 if(session.getAttribute("username")==null){
			 return new ModelAndView("login");
		 }else{
			 return new ModelAndView("tmall");
		 } 
	 }
	  
	 /**
	  * 加入购物车
	  * @param session 
	  * @param request
	  * @return
	  */
	 @RequestMapping(value="/forecart",method=RequestMethod.POST)
	 public ModelAndView forecart(HttpSession session,HttpServletRequest request,@RequestParam(value="pid") Integer pid){
		 if(session.getAttribute("username") == null){
			return new ModelAndView("login");
		}else{
			UserBean user = userservice.getUserByUsername((String)session.getAttribute("username"));
			ProductionBean production = productionservice.getProductionByid(pid);
			BuyCartBean buycart = null;
			try {
				buycart = buycartservice.getBuyCartByProductionid(production.getId());
			}catch(Exception e){
				logger.debug(e.getMessage());
			}
			
			int productionNumber = Integer.parseInt(request.getParameter("productNumberSetting"));
			double total = productionNumber * production.getPrice();
			if(buycart!=null){
				buycart.setNumber(productionNumber+buycart.getNumber());
				buycart.setTotal((productionNumber+buycart.getNumber())*production.getPrice());
				buycartservice.updateBuyCart(buycart);
			}else{
				buycart = new BuyCartBean();
				buycart.setNumber(productionNumber);
				buycart.setTotal(total);
				buycart.setUser_id(user.getId());
				buycart.setProduction_id(production.getId());
				buycartservice.insertBuyCart(buycart); 
				session.setAttribute("buycartcount", (int)session.getAttribute("buycartcount")+1);
			}
			return null;
		}
	 }
	 
	 /**
	  * 跳转购物车页面
	  * @param session
	  * @return
	  */ 
	 @RequestMapping(value="/buycart")
		public ModelAndView buycart(HttpSession session){
			if(session.getAttribute("username")==null){
				return new ModelAndView("login");
			}else{
				ModelAndView model = new ModelAndView("forecart");
				 Integer id = (Integer) session.getAttribute("userid");
				List<BuyCartBean> listcart = buycartservice.getAllBuyCart(id);
				Map<ProductionBean,BuyCartBean> productionmap = new HashMap<ProductionBean,BuyCartBean>();
				for(BuyCartBean buycart:listcart)
					productionmap.put(productionservice.getProductionByid(buycart.getProduction_id()), buycart);	
				model.addObject("productionmap", productionmap);
				return model;
			}
		}
	 
	 /**
	  * 跳转我的订单
	  * @param session
	  * @return
	  */
	 @RequestMapping(value="/forebought")
	 public ModelAndView forebought(HttpSession session){
		 if(session.getAttribute("username")==null){
			return new ModelAndView("login"); 
		 }else{
			 ModelAndView model = new ModelAndView("forebought");
			 Integer id = (Integer) session.getAttribute("userid");
			 List<ClientBean> clientlist = clientservice.getAllClient(id);
			 Map<ProductionBean,Integer> productionmap = null;
			 Map<ClientBean, Map<ProductionBean,Integer>> clientnmap = new HashMap<ClientBean, Map<ProductionBean,Integer>>();
			 Iterator<ClientBean> iterator = clientlist.iterator();
			 while(iterator.hasNext()){
				 productionmap = new HashMap<ProductionBean,Integer>();
				 ClientBean client = iterator.next();
				 String client_id = client.getClient_id();
				 List<OrderBean> listorder = orderservice.getAllOrderByclientid(client_id);
				 Iterator<OrderBean> orderiterator = listorder.iterator();
				 while(orderiterator.hasNext()) {
					 OrderBean order = orderiterator.next();
					 ProductionBean production = productionservice.getProductionByid(order.getProduction_id());
					 productionmap.put(production, order.getNumber());
				 }
				 clientnmap.put(client, productionmap);
			 }
			 session.setAttribute("clientnmap", clientnmap);
			 return model;	
		 }
	 }
	 
	 /** 
	  * 发货
	  * @param id
	  * @param session
	  * @return 
	  */
	 @RequestMapping(value="/delivery")
	 public ModelAndView delivery(@RequestParam(value="cid") int id,HttpSession session){
		 if(session.getAttribute("username")==null){ 
			 return new ModelAndView("login"); 
		 }else{ 
			 ClientBean client = clientservice.getClientByid(id);
			 client.setStatus(StatusEnum.waitConfirm);
			 clientservice.updateClientStatus(client);
			 return null; 
		 }
	 }
	 
	 
	 /** 
	  * 確認收貨
	  * @param id
	  * @param session
	  * @return 
	  */
	 @RequestMapping(value="/foreconfirmPay")
	 public ModelAndView foreconfirmPay(@RequestParam(value="cid") int client_id,HttpSession session){
		 if(session.getAttribute("username")==null){ 
			 return new ModelAndView("login"); 
		 }else{ 
			 ModelAndView model = new ModelAndView("foreconfirmPay");
			 Map<ProductionBean,Integer> productionmap = new HashMap<ProductionBean,Integer>();
			 ClientBean client = clientservice.getClientByid(client_id);
			 List<OrderBean> listorder = orderservice.getAllOrderByclientid(client.getClient_id());
			 Iterator<OrderBean> iterator = listorder.iterator();
			 while(iterator.hasNext()){
				 OrderBean order = iterator.next();
				 productionmap.put(productionservice.getProductionByid(order.getProduction_id()), order.getNumber());
			 }
			 model.addObject("productionmap", productionmap);
			 model.addObject("client", client);
			 return model; 
		 }
	 }
	 
	 /**
	  * 收貨
	  * @param client_id
	  * @param session
	  * @return
	  */
	 @RequestMapping(value="/foreorderConfirmed")
	 public ModelAndView foreorderConfirmed(@RequestParam(value="cid") int client_id,HttpSession session){
		 if(session.getAttribute("username")==null){ 
			 return new ModelAndView("login"); 
		 }else{ 
			 ClientBean client = clientservice.getClientByid(client_id);
			 client.setStatus(StatusEnum.waitReview);
			 clientservice.updateClientStatus(client);
			 return new ModelAndView("foreorderConfirmed");
		 }
	 }
	 
	 /**
	  * 评价界面
	  * @param client_id
	  * @param session
	  * @return
	  */
	 @RequestMapping(value="/forereview")
	 public ModelAndView forereview(@RequestParam(value="cid") int client_id,HttpSession session){
		 if(session.getAttribute("username")==null){ 
			 return new ModelAndView("login"); 
		 }else{ 
			 ModelAndView model = new ModelAndView("forereview");
			 Map<ProductionBean,OrderBean> productionmap = new HashMap<ProductionBean,OrderBean>();
			 ClientBean client = clientservice.getClientByid(client_id);
			 List<OrderBean> listorder = orderservice.getAllOrderByclientid(client.getClient_id());
			 Iterator<OrderBean> iterator = listorder.iterator();
			 while(iterator.hasNext()){
				 OrderBean order = iterator.next();
				 productionmap.put(productionservice.getProductionByid(order.getProduction_id()), order);
			 }
			 model.addObject("productionmap", productionmap);
			 model.addObject("client",client);
			 return model; 
		 }
	 }
	 
	 /**
	  * 提交评价
	  * @param client_id
	  * @param session
	  * @return
	  */
	 @RequestMapping(value="/foredoreview")
	 public ModelAndView foredoreview(HttpServletRequest request,HttpSession session){
		 if(session.getAttribute("username")==null){ 
			 return new ModelAndView("login"); 
		 }else{ 
			 int client_id = Integer.parseInt( request.getParameter("cid"));
			 ClientBean client = clientservice.getClientByid(client_id);
			 List<OrderBean> listorder = orderservice.getAllOrderByclientid(client.getClient_id());
			 Iterator<OrderBean> iterator = listorder.iterator();
			 ReviewBean review = new ReviewBean();
			 SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			 String time = df.format(new Date()); 
			 while(iterator.hasNext()){
				 OrderBean order = iterator.next();
				 int order_id = order.getId();
				 String reviewtext = request.getParameter("content"+order_id);
				 System.out.println(reviewtext);
				 if(reviewtext==null ||reviewtext==""){
					 reviewtext = "此用户未给予评价，默认好评";
				 }
				 review.setTime(time);
				 review.setReview(reviewtext);
				 review.setProduction_id(order.getProduction_id());
				 review.setUsername((String) session.getAttribute("username"));
				 reviewservice.insertReview(review);
			 } 
			 client.setStatus(StatusEnum.OK);
			 clientservice.updateClientStatus(client);
			 return new ModelAndView("tmall");
		 }
	 }
	 
	 /**
	  * 提交评价
	  * @param client_id
	  * @param session
	  * @return
	  */
	 @RequestMapping(value="/foredeleteOrder")
	 public ModelAndView foredeleteOrder(@RequestParam(value="cid") int cid,HttpSession session){
		 if(session.getAttribute("username")==null){ 
			 return new ModelAndView("login"); 
		 }else{ 
			 clientservice.deleteClient(cid);
			 return null;
		 }
	 }
}

