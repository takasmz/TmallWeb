package com.web.redis;

import java.io.UnsupportedEncodingException;
import java.util.List;

import org.springframework.stereotype.Repository;

/**
 * 目前只用来使用redis来缓存库存
 * @author Administrator
 *
 * @param <H>
 * @param <K>
 * @param <V>
 */
public interface RedisBaise<H,K,V> {
	//增
    public void add(K key,String value);
    public void addObj(H objectKey,V object);
    //删
    public void delete(K key);
    public void delete(List<K> listKeys);
    public void deletObj(H objecyKey,K key);
    //改
    public void update(K key,String value);
    public void updateObj(H objectKey,V object);
    //查
    public String get(K key);
    public V getObj(H objectKey,Class clazz);


    public Long getsize(H objectKey);
}
