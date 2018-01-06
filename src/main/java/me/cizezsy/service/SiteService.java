package me.cizezsy.service;

import java.util.List;

import me.cizezsy.dao.SiteDao;
import me.cizezsy.domain.Site;
import me.cizezsy.exception.SiteInfoNotExistException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class SiteService {

  private SiteDao siteDao;

  public Site getSite() throws SiteInfoNotExistException {
    List<Site> siteList = siteDao.loadAll();
    if (siteList.size() == 0) {
      throw new SiteInfoNotExistException();
    }
    return siteList.get(0);
  }

  @Transactional
  public void updateSite(Site site) {
    siteDao.update(site);
  }

  @Autowired
  public void setSiteDao(SiteDao siteDao) {
    this.siteDao = siteDao;
  }
}
