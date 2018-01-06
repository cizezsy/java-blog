package me.cizezsy.domain;

import java.util.ArrayList;
import java.util.List;
import javax.persistence.*;

import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;

@Entity
@Table(name = "blog_tag")
public class Tag extends BaseDomain {

  @Id
  @Column(name = "tag_name")
  private String tagName;

  @Fetch(FetchMode.SELECT)
  @ManyToMany(cascade = {CascadeType.PERSIST, CascadeType.MERGE}, fetch = FetchType.EAGER)
  @JoinTable(name = "blog_article_tag",
      joinColumns = {@JoinColumn(name = "tag_name")},
      inverseJoinColumns = {@JoinColumn(name = "article_id")})
  private List<Article> articleList = new ArrayList<>();


  public String getTagName() {
    return tagName;
  }

  public void setTagName(String tagName) {
    this.tagName = tagName;
  }
}
