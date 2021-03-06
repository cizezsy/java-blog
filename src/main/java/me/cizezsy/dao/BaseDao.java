package me.cizezsy.dao;

import org.hibernate.Session;
import org.hibernate.criterion.DetachedCriteria;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate5.HibernateTemplate;

import java.io.Serializable;
import java.util.Collection;
import java.util.List;

public class BaseDao<T> {
  private Class<T> entityClass;
  private HibernateTemplate hibernateTemplate;

  public BaseDao(Class<T> entityClass) {
    this.entityClass = entityClass;
  }

  public T load(Serializable id) {
    return getHibernateTemplate().load(entityClass, id);
  }

  public T get(Serializable id) {
    return getHibernateTemplate().get(entityClass, id);
  }

  public List<T> findByExample(T example) {
    return getHibernateTemplate().findByExample(example);
  }

  public List<T> findByExample(T example, int firstSize, int maxSize) {
    return getHibernateTemplate().findByExample(example, firstSize, maxSize);
  }

  public List<T> loadAll() {
    return getHibernateTemplate().loadAll(entityClass);
  }

  public Serializable save(T entity) {
    return getHibernateTemplate().save(entity);
  }

  public void remove(T entity) {
    getHibernateTemplate().delete(entity);
  }

  public void removeAll(Collection<T> collection) {
    getHibernateTemplate().deleteAll(collection);
  }

  public void update(T entity) {
    getHibernateTemplate().update(entity);
  }

  @SuppressWarnings("unchecked")
  public List<T> findByCriteria(DetachedCriteria criteria) {
    return (List<T>) getHibernateTemplate().findByCriteria(criteria);
  }
  @SuppressWarnings("unchecked")
  public List<T> findByCriteria(DetachedCriteria criteria, int first, int max) {
    return (List<T>) getHibernateTemplate().findByCriteria(criteria, first, max);
  }

  @Autowired
  public void setHibernateTemplate(HibernateTemplate hibernateTemplate) {
    this.hibernateTemplate = hibernateTemplate;
  }

  public HibernateTemplate getHibernateTemplate() {
    return hibernateTemplate;
  }

  public Session getSession() {
    return getHibernateTemplate().getSessionFactory().getCurrentSession();
  }
}
