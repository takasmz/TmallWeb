package com.web.redis;

import java.util.List;
import java.util.logging.Logger;

import javax.annotation.Resource;

import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Component;

import com.alibaba.fastjson.JSON;
import com.web.pojo.OrderBean;

@Component("OrderRedisImpl")
public class OrderRedisImpl implements RedisBaise<String,String,OrderBean>{

	@Resource(name="redisTemplate")
    private RedisTemplate redisTemplate;
	
	private Logger logger = Logger.getLogger(String.valueOf(RedisBaise.class));
	
	@Override
	public void add(String key, String value) {
		// TODO Auto-generated method stub
		if(redisTemplate==null){
            logger.warning("redisTemplate 瀹炰緥鍖栧け璐�");
            return;
        }else{
        	
           redisTemplate.opsForValue().set(key,value);
        }
	}

	@Override
	public void addObj(String objectKey, OrderBean object) {
		// TODO Auto-generated method stub
		 if(redisTemplate==null){
	            logger.warning("redisTemplate 瀹炰緥鍖栧け璐�");
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
	public void updateObj(String objectKey,OrderBean object) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public String get(String key) {
		// TODO Auto-generated method stub
		String value = (String) redisTemplate.opsForValue().get(key);
        return value;
	}

	@Override
	public OrderBean getObj(String objectKey,Class clazz) {
		// TODO Auto-generated method stub
		String value =  (String) redisTemplate.opsForValue().get(objectKey);
		 return (OrderBean) JSON.parseObject(value,clazz);
	}

	@Override
	public Long getsize(String objectKey) {
		// TODO Auto-generated method stub
		return redisTemplate.opsForHash().size(objectKey);
	}


}
