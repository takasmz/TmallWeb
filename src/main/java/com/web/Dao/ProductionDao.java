package com.web.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.web.pojo.ProductionBean;
import com.web.pojo.PropertyBean;
import com.web.pojo.TypeBean;

@Repository
public interface ProductionDao {
	/**
	 * 插入商品
	 * @param Production 商品
	 * @return 
	 */
	public int insertProduction(ProductionBean Production);
	/**
	 * 删除商品
	 * @param id 商品id
	 * @return
	 */
	public int deleteProduction(Integer id);
	/**
	 * 更新商品
	 * @param Production 商品
	 * @return
	 */
	public int updateProduction(ProductionBean Production);
	/**
	 * 根据商品id查询商品
	 * @param id 商品id
	 * @return
	 */
	public ProductionBean getProductionByid(Integer id);
	/**
	 * 根据商品名称查询商品
	 * @param Production_Name 商品名称
	 * @return
	 */
	public List<ProductionBean> getProductionByname(String Production_Name);
	/**
	 * 根据商品类型查询商品
	 * @param tid 类型id
	 * @return 
	 */
	public List<ProductionBean> getProductionBytid(int tid);
	/**
	 * 根据商品品牌查询商品
	 * @param Production_brands 商品品牌
	 * @return
	 */
	public List<ProductionBean> getProductionBybrands(String Production_brands);
	/**
	 * 得到商品图片路径
	 * @param id 商品Id
	 * @return
	 */
	public String getimgpathByid(Integer id);
	/**
	 *  根据商品id得到商品的属性
	 * @param pid 商品id
	 * @return
	 */
	public List<PropertyBean> getPropertyBypid(int pid);
	/**
	 *  根据类型id得到商品的属性
	 * @param tid 类型id
	 * @return
	 */
	public List<PropertyBean> getPropertyBytid(int tid);
	/**
	 * 查询类型
	 * @param n
	 * @return
	 */
	public List<ProductionBean> getallproduction();
	/**
	 * 更新库存
	 * @param id
	 * @param stock
	 */
	public void updateStockAndSales(@Param(value="id")int id,@Param(value="stock")Integer stock,@Param(value="sales_volume")Integer sales_volume);
}
