package me.cizezsy.service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

import me.cizezsy.dao.TagDao;
import me.cizezsy.domain.Tag;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class TagService {

  private TagDao tagDao;

  @Transactional
  public List<Tag> mapToTag(String tag) {
    if (StringUtils.isEmpty(tag)) {
      return new ArrayList<>();
    }
    List<Tag> tags = Arrays.stream(tag.split(","))
        .map(s -> {
          Tag t = new Tag();
          t.setTagName(s);
          return t;
        })
        .collect(Collectors.toList());
    tags.forEach(t -> {
      if (tagDao.get(t.getTagName()) == null) {
        tagDao.save(t);
      }
    });
    return tags;
  }

  @Autowired
  public void setTagDao(TagDao tagDao) {
    this.tagDao = tagDao;
  }
}
