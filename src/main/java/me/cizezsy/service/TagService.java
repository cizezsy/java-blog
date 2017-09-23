package me.cizezsy.service;

import me.cizezsy.dao.TagDao;
import me.cizezsy.domain.Tag;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class TagService {

    private TagDao tagDao;

    public List<Tag> mapToTag(String tag) {
        List<Tag> tags = Arrays.stream(tag.split(","))
                .map(s -> {
                    Tag t = new Tag();
                    t.setTagName(s);
                    return t;
                })
                .collect(Collectors.toList());
        tags.forEach(t -> {
            if (tagDao.findByExample(t).size() == 0)
                tagDao.save(t);
        });
        return tags;
    }

    @Autowired
    public void setTagDao(TagDao tagDao) {
        this.tagDao = tagDao;
    }
}
