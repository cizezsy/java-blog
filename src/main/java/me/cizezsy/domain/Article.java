package me.cizezsy.domain;

import org.hibernate.annotations.Type;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

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
    private String articleContent;
    @Column(name = "article_raw_content")
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
    private boolean isTop;
    @Column(name = "is_publish")
    private boolean isPublish = true;

    @ManyToMany(cascade = {CascadeType.PERSIST, CascadeType.MERGE})
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
        int result;
        if ((result = this.getCreateTime().compareTo(o.getCreateTime())) != 0) {
            return result;
        }
        return getArticleTitle().compareTo(o.getArticleTitle());
    }
}
