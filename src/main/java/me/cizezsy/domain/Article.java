package me.cizezsy.domain;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.UUID;
import javax.persistence.*;
import javax.xml.bind.annotation.XmlElement;

import org.apache.commons.lang3.builder.EqualsBuilder;
import org.apache.commons.lang3.builder.HashCodeBuilder;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;
import org.hibernate.annotations.Type;

@Entity
@Table(name = "blog_article")
public class Article extends BaseDomain implements Comparable<Article> {

  @Id
  @GeneratedValue
  @Type(type = "uuid-char")
  @Column(name = "article_id")
  private UUID articleId;
  @Column(name = "article_title")
  private String articleTitle;
  @Column(name = "article_content")
  @XmlElement
  private String articleContent;
  @Column(name = "article_raw_content")
  @XmlElement
  private String articleRawContent;
  @Column(name = "article_abstract")
  private String articleAbstract;
  @Column(name = "create_time")
  private LocalDateTime createTime;
  @Column(name = "update_time")
  private LocalDateTime updateTime;
  @ManyToOne
  @JoinColumn(name = "user_id")
  private User user;
  @ManyToOne
  @JoinColumn(name = "category_id")
  private Category category;
  @Column(name = "view_count")
  private int viewCount;
  @Column(name = "is_top")
  private Boolean isTop;
  @Column(name = "is_publish")
  private Boolean isPublish;

  @Column(name = "article_bg_url")
  private String articleBgUrl;

  @Fetch(FetchMode.SELECT)
  @ManyToMany(cascade = {CascadeType.PERSIST, CascadeType.MERGE}, fetch = FetchType.EAGER)
  @JoinTable(name = "blog_article_tag",
      joinColumns = {@JoinColumn(name = "article_id")},
      inverseJoinColumns = {@JoinColumn(name = "tag_name")})
  private List<Tag> tagList = new ArrayList<>();


  public UUID getArticleId() {
    return articleId;
  }

  public void setArticleId(UUID articleId) {
    this.articleId = articleId;
  }

  public String getArticleTitle() {
    return articleTitle;
  }

  public void setArticleTitle(String articleTitle) {
    this.articleTitle = articleTitle;
  }

  public String getArticleContent() {
    return articleContent;
  }

  public void setArticleContent(String articleContent) {
    this.articleContent = articleContent;
  }

  public String getArticleAbstract() {
    return articleAbstract;
  }

  public void setArticleAbstract(String articleAbstract) {
    this.articleAbstract = articleAbstract;
  }

  public String getArticleBgUrl() {
    return articleBgUrl;
  }

  public void setArticleBgUrl(String articleBgUrl) {
    this.articleBgUrl = articleBgUrl;
  }

  public LocalDateTime getCreateTime() {
    return createTime;
  }

  public void setCreateTime(LocalDateTime createTime) {
    this.createTime = createTime;
  }

  public LocalDateTime getUpdateTime() {
    return updateTime;
  }

  public void setUpdateTime(LocalDateTime updateTime) {
    this.updateTime = updateTime;
  }

  public User getUser() {
    return user;
  }

  public void setUser(User user) {
    this.user = user;
  }

  public Category getCategory() {
    return category;
  }

  public void setCategory(Category category) {
    this.category = category;
  }

  public int getViewCount() {
    return viewCount;
  }

  public void setViewCount(int viewCount) {
    this.viewCount = viewCount;
  }

  public boolean isTop() {
    return isTop;
  }

  public void setTop(boolean top) {
    isTop = top;
  }

  public boolean isPublish() {
    return isPublish;
  }

  public void setPublish(boolean publish) {
    isPublish = publish;
  }

  public List<Tag> getTagList() {
    return tagList;
  }

  public void setTagList(List<Tag> tagList) {
    this.tagList = tagList;
  }

  public String getArticleRawContent() {
    return articleRawContent;
  }

  public void setArticleRawContent(String articleRawContent) {
    this.articleRawContent = articleRawContent;
  }

  @Override
  public int compareTo(Article o) {
    if (!Objects.equals(this.getCreateTime(), o.getCreateTime())) {
      return this.getCreateTime().compareTo(o.getCreateTime());
    }
    return getArticleTitle().compareTo(o.getArticleTitle());
  }

  @Override
  public boolean equals(Object obj) {
    return obj instanceof Article && EqualsBuilder.reflectionEquals(this, obj, false);
  }

  @Override
  public int hashCode() {
    return HashCodeBuilder.reflectionHashCode(this, false);
  }
}
