-- MySQL dump 10.13  Distrib 5.7.12, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: blog
-- ------------------------------------------------------
-- Server version	5.7.12

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `blog_article`
--

DROP TABLE IF EXISTS `blog_article`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `blog_article` (
  `article_id` varchar(64) NOT NULL,
  `article_title` varchar(64) NOT NULL,
  `article_content` text,
  `article_abstract` varchar(128) DEFAULT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `user_id` varchar(64) NOT NULL,
  `view_count` int(11) DEFAULT '0',
  `is_top` tinyint(1) DEFAULT '0',
  `is_publish` tinyint(1) DEFAULT '1',
  `category_id` varchar(64) DEFAULT NULL,
  `article_raw_content` text,
  PRIMARY KEY (`article_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blog_article`
--

LOCK TABLES `blog_article` WRITE;
/*!40000 ALTER TABLE `blog_article` DISABLE KEYS */;
INSERT INTO `blog_article` VALUES ('72b0a132-47aa-4e2f-86af-d780ca8d2d6d','从零开始搭建博客——Spring Security 403错误','<h5 id=\"springsecurity403\">Spring Security 403</h5>\n<hr>\n<p>上午给博客加上了Spring Security用以权限控制，但是不知道为什么一直403错误。</p>\n<p>一开始，报错提示：</p>\n<blockquote>\n  <p>Forbidden (403) CSRF verification failed. Request aborted. Even using the {% csrf_token %}</p>\n</blockquote>\n<p>之后在配置中将其disable了</p>\n<pre><code class=\"hljs java\"><span class=\"hljs-function\"><span class=\"hljs-keyword\">protected</span> <span class=\"hljs-keyword\">void</span> <span class=\"hljs-title\">configure</span><span class=\"hljs-params\">(HttpSecurity http)</span> <span class=\"hljs-keyword\">throws</span> Exception </span>{\n    http.csrf().disable()\n}\n</code></pre>\n<p>但依然还是提示403 Forbidden，验证失败。最后debug了很久，终于发现原因。</p>\n<p>在SpringSecurity配置访问所需角色时，我设置的是 <code>USER</code></p>\n<pre><code class=\"java language-java hljs\">http.authorizeRequests.antMatchers(<span class=\"hljs-string\">\"/admin/**\"</span>).hasRole(<span class=\"hljs-string\">\"USER\"</span>)\n</code></pre>\n<p>然而给用户设置角色时，不能设置为<code>USER</code>。必须在前面加上<code>ROLE_</code>。</p>\n<pre><code class=\"java language-java hljs\">authorities.add(<span class=\"hljs-keyword\">new</span> SimpleGrantedAuthority(<span class=\"hljs-string\">\"ROLE_USER\"</span>));\n</code></pre>\n<p>这样才能匹配上Spring Security设置的USER角色</p>\n<hr>\n<blockquote>\n  <p>博客持续施工中.......</p>\n</blockquote>',NULL,'2017-09-27 06:38:25','2017-09-27 06:38:25','123e4567-e89b-12d3-a456-426655440000',0,1,1,NULL,'###Spring Security 403\n\n-------\n上午给博客加上了Spring Security用以权限控制，但是不知道为什么一直403错误。\n\n一开始，报错提示：\n\n> Forbidden (403) CSRF verification failed. Request aborted. Even using the {% csrf_token %}\n\n之后在配置中将其disable了\n```\nprotected void configure(HttpSecurity http) throws Exception {\n    http.csrf().disable()\n}\n\n```\n\n但依然还是提示403 Forbidden，验证失败。最后debug了很久，终于发现原因。\n\n在SpringSecurity配置访问所需角色时，我设置的是 `USER`\n```java\nhttp.authorizeRequests.antMatchers(\"/admin/**\").hasRole(\"USER\")\n```\n然而给用户设置角色时，不能设置为`USER`。必须在前面加上`ROLE_`。\n```java\nauthorities.add(new SimpleGrantedAuthority(\"ROLE_USER\"));\n```\n\n这样才能匹配上Spring Security设置的USER角色\n\n-------\n\n> 博客持续施工中.......\n\n\n');
/*!40000 ALTER TABLE `blog_article` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blog_article_tag`
--

DROP TABLE IF EXISTS `blog_article_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `blog_article_tag` (
  `article_tag_id` int(11) NOT NULL AUTO_INCREMENT,
  `article_id` varchar(64) DEFAULT NULL,
  `tag_name` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`article_tag_id`)
) ENGINE=InnoDB AUTO_INCREMENT=98 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blog_article_tag`
--

LOCK TABLES `blog_article_tag` WRITE;
/*!40000 ALTER TABLE `blog_article_tag` DISABLE KEYS */;
INSERT INTO `blog_article_tag` VALUES (94,'72b0a132-47aa-4e2f-86af-d780ca8d2d6d','spring'),(95,'72b0a132-47aa-4e2f-86af-d780ca8d2d6d','java'),(96,'72b0a132-47aa-4e2f-86af-d780ca8d2d6d','spring-security'),(97,'72b0a132-47aa-4e2f-86af-d780ca8d2d6d','java web');
/*!40000 ALTER TABLE `blog_article_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blog_category`
--

DROP TABLE IF EXISTS `blog_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `blog_category` (
  `category_id` varchar(64) NOT NULL,
  `category_title` varchar(32) NOT NULL,
  `category_desc` varchar(256) DEFAULT NULL,
  `category_order` int(11) DEFAULT NULL,
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blog_category`
--

LOCK TABLES `blog_category` WRITE;
/*!40000 ALTER TABLE `blog_category` DISABLE KEYS */;
/*!40000 ALTER TABLE `blog_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blog_menu`
--

DROP TABLE IF EXISTS `blog_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `blog_menu` (
  `menu_id` varchar(64) NOT NULL,
  `menu_name` varchar(64) NOT NULL,
  `menu_url` varchar(256) DEFAULT NULL,
  `menu_type` int(1) NOT NULL,
  `parent_id` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`menu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blog_menu`
--

LOCK TABLES `blog_menu` WRITE;
/*!40000 ALTER TABLE `blog_menu` DISABLE KEYS */;
/*!40000 ALTER TABLE `blog_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blog_tag`
--

DROP TABLE IF EXISTS `blog_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `blog_tag` (
  `tag_name` varchar(32) NOT NULL,
  PRIMARY KEY (`tag_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blog_tag`
--

LOCK TABLES `blog_tag` WRITE;
/*!40000 ALTER TABLE `blog_tag` DISABLE KEYS */;
INSERT INTO `blog_tag` VALUES ('java'),('java web'),('spring'),('spring-security');
/*!40000 ALTER TABLE `blog_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blog_user`
--

DROP TABLE IF EXISTS `blog_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `blog_user` (
  `user_id` varchar(64) NOT NULL,
  `user_name` varchar(32) NOT NULL,
  `password` varchar(32) NOT NULL,
  `user_avatar` varchar(512) DEFAULT NULL,
  `last_visit` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `last_ip` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blog_user`
--

LOCK TABLES `blog_user` WRITE;
/*!40000 ALTER TABLE `blog_user` DISABLE KEYS */;
INSERT INTO `blog_user` VALUES ('123e4567-e89b-12d3-a456-426655440000','cizezsy','123456',NULL,'2017-09-05 12:36:38',NULL);
/*!40000 ALTER TABLE `blog_user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-11-27  8:37:21
