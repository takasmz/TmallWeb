package com.web.config;

import redis.clients.jedis.Jedis;

public class Test {
	public static void main(String[] args) {
		Jedis redis=new Jedis("127.0.0.1",6379);
		redis.auth("qwas74186");
		System.out.println(redis.ping());  
	}
}
