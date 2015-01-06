package cn.martin.springmvc.admin.dao;

import java.io.Serializable;
import java.lang.reflect.ParameterizedType;
import java.util.List;

import javax.annotation.Resource;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

public abstract class BaseDaoImpl<T, PK extends Serializable> implements IBaseDao<T, PK> {

	protected Class<T> clazz;// DAO所管理的Entity类型.

	@Resource(name = "sessionFactory")
	private SessionFactory sessionFactory;

	public Session getSession() {
		return sessionFactory.getCurrentSession();
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	public BaseDaoImpl() {
		ParameterizedType type = (ParameterizedType) this.getClass().getGenericSuperclass();
		this.clazz = (Class) type.getActualTypeArguments()[0];
	}

	public void save(T t) {
		sessionFactory.getCurrentSession().saveOrUpdate(t);
	}

	@SuppressWarnings("unchecked")
	public T get(PK id) {
		return (T) sessionFactory.getCurrentSession().get(clazz, id);
	}

	public void delete(T o) {
		sessionFactory.getCurrentSession().delete(o);
	}

	@SuppressWarnings("unchecked")
	public List<T> findAll() {
		return sessionFactory.getCurrentSession().createCriteria(clazz).list();
	}
	

	@SuppressWarnings("unchecked")
	public List<T> findList(String hql) {
		return sessionFactory.getCurrentSession().createQuery(hql).list();
	}

	/**
	 * 分页查找;
	 * 
	 * @param hql
	 * @param page
	 * @param size
	 * @param objects
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<T> pageQuery(String hql, Integer page, Integer size, Object... objects) {
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery(hql);
		if (objects != null) {
			for (int i = 0; i < objects.length; i++) {
				query.setParameter(i, objects[i]);
			}
		}
		if (page != null && size != null) {
			query.setFirstResult((page - 1) * size).setMaxResults(size);// 分页操作;
		}
		List<T> list = query.list();
		return list;
	}

}
