package me.cizezsy.web.admin;

import me.cizezsy.domain.JsonMessage;
import me.cizezsy.domain.Site;
import me.cizezsy.exception.SiteInfoNotExistException;
import me.cizezsy.service.SiteService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/admin")
public class SiteAdminController {

    private SiteService siteService;

    @RequestMapping(value = "/site", method = RequestMethod.GET)
    public String site(Model model) {
        Site site;
        try {
            site = siteService.getSite();
        } catch (SiteInfoNotExistException e) {
            e.printStackTrace();
            return "redirect:/error/500";
        }
        model.addAttribute("site", site);
        return "/admin/site-admin";
    }

    @RequestMapping(value = "/site",
            method = RequestMethod.POST,
            params = {"siteName", "siteMotto", "siteLongMotto", "siteBg"})
    public @ResponseBody
    JsonMessage siteUpdate(@RequestParam("siteName") String siteName,
                           @RequestParam("siteMotto") String siteMotto,
                           @RequestParam("siteLongMotto") String siteLongMotto,
                           @RequestParam("siteBg") String siteBg) {
        Site site;
        try {
            site = siteService.getSite();
        } catch (SiteInfoNotExistException e) {
            return new JsonMessage(JsonMessage.STATUS_ERROR, "修改失败");
        }
        site.setSiteName(siteName);
        site.setSiteMotto(siteMotto);
        site.setSiteLongMotto(siteLongMotto);
        site.setSiteBg(siteBg);
        siteService.updateSite(site);
        return new JsonMessage(JsonMessage.STATUS_OK, "修改成功");
    }

    @Autowired
    public void setSiteService(SiteService siteService) {
        this.siteService = siteService;
    }
}
