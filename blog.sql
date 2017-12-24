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
INSERT INTO `blog_article` VALUES ('881b3495-0935-4026-9634-9a0a927274cb','添加了快速目录创建功能与检索功能','<h5 id=\"\">说明</h5>\n<ol>\n<li><p>增加了快速目录创建功能，只要把鼠标文章列表目录table header处，就能看到功能按钮。</p></li>\n<li><p>添加了检索功能，能通过时间范围及目录检索文章。</p></li>\n</ol>\n<blockquote>\n  <p>逐渐完善中</p>\n</blockquote>',NULL,'2017-12-24 02:53:39','2017-12-24 02:53:39','123e4567-e89b-12d3-a456-426655440000',0,1,1,'0a46c981-9af6-4af0-a574-dada394bf489','###说明\n1. 增加了快速目录创建功能，只要把鼠标文章列表目录table header处，就能看到功能按钮。\n\n2. 添加了检索功能，能通过时间范围及目录检索文章。\n\n> 逐渐完善中');
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
INSERT INTO `blog_category` VALUES ('0a46c981-9af6-4af0-a574-dada394bf489','java','java编程相关',0),('38a0803e-a241-4c42-9e0f-919f79ee9f58','日常','日常生活记录',2);
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
-- Table structure for table `blog_site`
--

DROP TABLE IF EXISTS `blog_site`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `blog_site` (
  `site_id` int(11) NOT NULL,
  `site_name` varchar(64) NOT NULL,
  `site_motto` varchar(32) NOT NULL,
  `site_long_motto` text,
  `site_bg` varchar(1024) NOT NULL,
  PRIMARY KEY (`site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blog_site`
--

LOCK TABLES `blog_site` WRITE;
/*!40000 ALTER TABLE `blog_site` DISABLE KEYS */;
INSERT INTO `blog_site` VALUES (1,'彩笺','未有知而不行者，知而不行，只是未知','When I was a child I ate a lot of food.\nMost of it is long gone and forgotten,\nbut certainly some of it became my very bones and flesh.\nThink of reading as the same thing for the mind.','/image/11.png');
/*!40000 ALTER TABLE `blog_site` ENABLE KEYS */;
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

-- Dump completed on 2017-12-24 22:00:20
