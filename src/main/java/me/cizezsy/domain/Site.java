package me.cizezsy.domain;

import javax.persistence.*;

@Entity
@Table(name = "blog_site")
public class Site extends BaseDomain {

    @Id
    @Column(name = "site_id")
    @GeneratedValue
    private int siteId;

    @Column(name = "site_name")
    private String siteName;
    @Column(name = "site_motto")
    private String siteMotto;
    @Column(name = "site_long_motto")
    private String siteLongMotto;
    @Column(name = "site_bg")
    private String siteBg;

    public String getSiteName() {
        return siteName;
    }

    public void setSiteName(String siteName) {
        this.siteName = siteName;
    }

    public String getSiteMotto() {
        return siteMotto;
    }

    public void setSiteMotto(String siteMotto) {
        this.siteMotto = siteMotto;
    }

    public String getSiteLongMotto() {
        return siteLongMotto;
    }

    public void setSiteLongMotto(String siteLongMotto) {
        this.siteLongMotto = siteLongMotto;
    }

    public String getSiteBg() {
        return siteBg;
    }

    public void setSiteBg(String siteBg) {
        this.siteBg = siteBg;
    }

    public int getSiteId() {
        return siteId;
    }

    public void setSiteId(int siteId) {
        this.siteId = siteId;
    }
}
