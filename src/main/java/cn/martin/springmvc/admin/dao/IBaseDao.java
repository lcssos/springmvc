package cn.martin.springmvc.admin.dao;

import java.io.Serializable;
import java.util.List;

public interface IBaseDao<T,PK extends Serializable> {

	public void save(T t);

	public T get(PK id);

	public void delete(T o);
	
	public List<T> findAll();
	public List<T> findList(String hql);

	public List<T> pageQuery(String hql, Integer page, Integer size, Object... objects);


}
