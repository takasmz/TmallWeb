package com.web.controller;

import java.security.MessageDigest;
import java.util.List;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.web.pojo.UserBean;
import com.web.service.UserService;


@Controller
public class UserController {
	
	@Autowired
	private UserService userservice = null;
	
	
	@RequestMapping("/login")
	public String loginPage(){
		return "login";
	}
	
	@RequestMapping(value="/quitlogin")
	public ModelAndView quitlogin(HttpSession session) {
		session.removeAttribute("username");
		session.removeAttribute("userid");
		return new ModelAndView("login");
	}
	
	@RequestMapping(value = "/loginCheck")
	public ModelAndView loginCheck(String username,String password,HttpSession session){
		
		int VaildUser = userservice.getMatchCount(username, password);
		if(VaildUser == 0){
			session.setAttribute("error", "用户名 密码错误");
			//System.out.println("用户名 密码错误");
			return new ModelAndView("login");
		}else if(VaildUser>1){
			session.setAttribute("error", "用户名和密码不能为空");
			//System.out.println("用户名和密码不能为空");
			return new ModelAndView("login");
		}else{
			session.removeAttribute("error");
			UserBean user1 = userservice.getUserByUsername(username);
			session.setAttribute("username", username);
			session.setAttribute("userid", user1.getId());
			//System.out.println("success");
			return new ModelAndView("/tmall");
		}
	}
	
	
	@RequestMapping(value = "/logincheck")
	public String logincheck(String username,String password){
		System.out.println("lalala");
		int VaildUser = userservice.getMatchCount(username, password);
		if(VaildUser == 1){
			return "success";
		}else{
			return "error";
		}
	}
	
	/**
     * 用户注册：先对数据进行校验，再注册，发送邮件激活
     *
     * @param user          用户POJO
     * @param bindingResult 校验的结果
     * @return 重定向到页面
     * @throws Exception
     */
	
    @RequestMapping("/register")
    public ModelAndView register(@Valid UserBean user, BindingResult bindingResult,HttpSession session) throws Exception {

    	
        //如果参数不对，就直接返回注册页面
        List<ObjectError> allErrors = bindingResult.getAllErrors();
        List<FieldError> fieldErrors = bindingResult.getFieldErrors();
        String error;
        if (allErrors != null && allErrors.size() > 0) {
        	session.removeAttribute("errorusername"); 
    		session.removeAttribute("errorpassword"); 
    		session.removeAttribute("errornickname"); 
    		session.removeAttribute("errormail"); 
        	for(FieldError fielderror:fieldErrors){
        		
        		error = fielderror.getDefaultMessage();
        		if(error.contains("用户名")){
        			session.setAttribute("errorusername",error);
        		}else if(error.contains("密码")){
        			session.setAttribute("errorpassword",error);
        		}else if(error.contains("昵称")){
        			session.setAttribute("errornickname",error);
        		}else if(error.contains("邮箱")){
        			session.setAttribute("errormail",error);
        		}
        		System.out.println(error);
        	}
            return new ModelAndView("redirect:/jsp/register.jsp");
        }else{

        	session.invalidate();
        //对密码进行加密md5(密码+salt)后才存到数据库中
       // userservice.encryptedPassword(user);
        try {
        	MessageDigest md = MessageDigest.getInstance("MD5");
        	byte[] bytes = md.digest(user.getPassword().getBytes("utf-8"));
        	user.setPassword(toHex(bytes));
            }
            catch (Exception e) {
                throw new RuntimeException(e);
            }
        userservice.insertUser(user);

        //提示用户发送了邮件，让用户激活账户
       // String url = getProjectPath() + "/user/activate.do?userId=" + user.getUserId();
       // emailService.sendEmail(user, "注册", url);

        return new ModelAndView("redirect:/jsp/login.jsp");
        }
    }
	
    
    public static String toHex(byte[] bytes) {

        final char[] HEX_DIGITS = "0123456789ABCDEF".toCharArray();
        StringBuilder ret = new StringBuilder(bytes.length * 2);
        for (int i=0; i<bytes.length; i++) {
            ret.append(HEX_DIGITS[(bytes[i] >> 4) & 0x0f]);
            ret.append(HEX_DIGITS[bytes[i] & 0x0f]);
        }
        return ret.toString();
    }

}
