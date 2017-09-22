package me.cizezsy.domain;

import org.hibernate.annotations.Type;

import javax.persistence.*;
import java.util.UUID;

@Entity
@Table(name = "blog_tag")
public class Tag extends BaseDomain {

    @Id
    @Column(name = "tag_name")
    private String tagName;


    public String getTagName() {
        return tagName;
    }

    public void setTagName(String tagName) {
        this.tagName = tagName;
    }
}
