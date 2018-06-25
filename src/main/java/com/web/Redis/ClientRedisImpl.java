package com.web.redis;

import java.util.List;
import java.util.logging.Logger;

import javax.annotation.Resource;

import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Component;

import com.alibaba.fastjson.JSON;
import com.web.pojo.ClientBean;


@Component("ClientRedisImpl")
public class ClientRedisImpl implements RedisBaise<String,String,ClientBean>{

	@Resource(name="redisTemplate")
    private RedisTemplate<String, Object> redisTemplate;
	
	private Logger logger = Logger.getLogger(String.valueOf(RedisBaise.class));
	
	@Override
	public void add(String key, String value) {
		// TODO Auto-generated method stub
		if(redisTemplate==null){
            logger.warning("redisTemplate 实例化失败");
            return;
        }else{
           redisTemplate.opsForValue().set(key,value);
        }
	}

	@Override
	public void addObj(String objectKey,ClientBean object) {
		// TODO Auto-generated method stub
		 if(redisTemplate==null){
	            logger.warning("redisTemplate 实例化失败");
	            return;
	        }else{
	            redisTemplate.opsForValue().set(objectKey,JSON.toJSONString(object));
	        }
	}

	@Override
	public void delete(String key) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void delete(List<String> listKeys) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deletObj(String objecyKey, String key) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void update(String key, String value) {
		// TODO Auto-generated method stub
	}

	@Override
	public void updateObj(String objectKey, ClientBean object) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public String get(String key) {
		// TODO Auto-generated method stub
		String value = (String) redisTemplate.opsForValue().get(key);
        return value;
	}

	@Override
	public ClientBean getObj(String objectKey,Class clazz) {
		// TODO Auto-generated method stub
		String value =  (String) redisTemplate.opsForValue().get(objectKey);
		 return (ClientBean) JSON.parseObject(value,clazz);
	}
	
	@Override
	public Long getsize(String objectKey) {
		// TODO Auto-generated method stub
		return redisTemplate.opsForHash().size(objectKey);
	}

	


}
