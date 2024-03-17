-- MySQL dump 10.13  Distrib 8.0.29, for Win64 (x86_64)
--
-- Host: 47.115.223.124    Database: suit
-- ------------------------------------------------------
-- Server version	5.7.40-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `category_no` varchar(32) NOT NULL COMMENT '分类编号',
  `category_alias` varchar(32) NOT NULL COMMENT '分类名称',
  `create_user` bigint(20) DEFAULT NULL COMMENT '创建人ID',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_user` bigint(20) DEFAULT NULL COMMENT '更新人ID',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=86 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (68,'accessory','饰品',44,'2023-12-11 11:09:22',44,'2023-12-11 11:09:22'),(70,'belt','皮带',NULL,'2023-12-13 11:36:47',43,'2023-12-13 11:36:47'),(71,'hat','帽子',53,'2023-12-06 10:50:30',53,'2023-12-06 10:50:30'),(72,'jeans','裤子',53,'2023-12-06 10:50:43',53,'2023-12-06 10:50:43'),(73,'outwear','外套',44,'2023-12-11 11:12:01',29,'2023-12-11 11:12:01'),(74,'shirt','衬衫',53,'2023-12-06 10:51:22',53,'2023-12-06 10:51:22'),(75,'shoe','鞋',53,'2023-12-06 10:51:32',53,'2023-12-06 10:51:32'),(76,'skirt','裙子',53,'2023-12-06 10:51:46',53,'2023-12-06 10:51:46'),(77,'suit','西装',53,'2023-12-06 10:51:57',53,'2023-12-06 10:51:57'),(78,'sweater','毛衣',53,'2023-12-06 10:52:11',53,'2023-12-06 10:52:11'),(79,'tshirt','T恤',53,'2023-12-06 10:53:13',53,'2023-12-06 10:53:13'),(80,'underWear','内衣',53,'2023-12-06 10:53:29',53,'2023-12-06 10:53:29'),(84,'bag','包',29,'2023-12-11 11:11:40',29,'2023-12-11 11:11:40');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clothes`
--

DROP TABLE IF EXISTS `clothes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clothes` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `clothes_no` varchar(32) NOT NULL COMMENT '编号',
  `clothes_alias` varchar(32) NOT NULL COMMENT '名称',
  `price` decimal(10,2) NOT NULL COMMENT '价格',
  `sex` bit(1) NOT NULL COMMENT '性别 0 女 1 男',
  `category_id` bigint(20) NOT NULL COMMENT '分类id',
  `img` varchar(255) NOT NULL COMMENT '图片',
  `create_user` bigint(20) DEFAULT NULL COMMENT '创建人ID',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_user` bigint(20) DEFAULT NULL COMMENT '更新人ID',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `外键_name` (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=80 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clothes`
--

LOCK TABLES `clothes` WRITE;
/*!40000 ALTER TABLE `clothes` DISABLE KEYS */;
INSERT INTO `clothes` VALUES (16,'wSuit01','女西装',900.10,_binary '\0',77,'wSuit01.png',NULL,'2023-12-13 10:54:36',29,'2023-12-14 15:47:07'),(33,'wSkirt06','雀金裙',290.00,_binary '\0',76,'wSkirt07.png',29,'2023-12-11 11:27:59',29,'2023-12-11 11:28:15'),(41,'mOutWear01','男休闲皮外套',500.00,_binary '',73,'mOutWear01.png',29,'2023-12-11 11:23:21',29,'2023-12-11 11:24:35'),(42,'mBelt01','男休闲皮带',200.00,_binary '',70,'mBelt01.png',29,'2023-12-11 11:16:32',29,'2023-12-11 11:17:01'),(43,'mJean01','男休闲牛仔裤',358.00,_binary '',72,'mJean02.png',29,'2023-12-11 11:21:35',29,'2023-12-11 11:21:50'),(44,'mJean02','男休闲牛仔裤',288.00,_binary '',72,'mJean01.png',29,'2023-12-11 11:22:33',29,'2023-12-11 11:22:42'),(45,'wSkirt05','碎花中裙长袖',390.00,_binary '\0',76,'wSkirt05.png',29,'2023-12-11 12:31:35',29,'2023-12-11 13:29:56'),(46,'wSkirt04','碎花中裙短袖',299.00,_binary '\0',76,'wSkirt04.png',29,'2023-12-11 12:32:24',29,'2023-12-11 13:29:42'),(47,'wSkirt03','黑色杂花连衣裙',680.00,_binary '\0',76,'wSkirt03.png',29,'2023-12-11 12:32:35',29,'2023-12-11 13:30:13'),(48,'wSkirt02','深棕色连衣裙',450.00,_binary '\0',76,'wSkirt02.png',29,'2023-12-11 13:30:56',29,'2023-12-11 13:31:09'),(49,'wSkirt01','灰色连衣裙',360.00,_binary '\0',76,'wSkirt01.png',29,'2023-12-11 13:31:46',29,'2023-12-11 13:32:01'),(50,'wShoe01','女鞋',400.00,_binary '\0',75,'wShoe01.png',29,'2023-12-11 13:32:50',29,'2023-12-11 13:33:08'),(51,'wShirt03','蓝色花衫',360.00,_binary '\0',74,'wShirt03.png',29,'2023-12-11 13:34:22',29,'2023-12-11 13:34:52'),(52,'wShirt02','红色点衫',320.00,_binary '\0',74,'wShirt02.png',29,'2023-12-11 13:35:31',29,'2023-12-11 13:35:45'),(53,'wShirt01','碎花衫',280.00,_binary '\0',74,'wShirt01.png',29,'2023-12-11 13:36:43',29,'2023-12-11 13:36:55'),(54,'wJean05','黑色短裤',180.00,_binary '\0',72,'wJean05.png',29,'2023-12-11 13:37:53',29,'2023-12-11 13:38:16'),(55,'wJean04','奶白长裤',280.00,_binary '\0',72,'wJean04.png',29,'2023-12-11 13:38:50',29,'2023-12-11 13:39:11'),(56,'wJean03','红色短裤',180.00,_binary '\0',72,'wJean03.png',29,'2023-12-11 13:39:52',29,'2023-12-11 13:40:01'),(57,'wJean02','蓝灰短裤',180.00,_binary '\0',72,'wJean02.png',29,'2023-12-11 13:43:08',29,'2023-12-11 13:43:40'),(58,'wJean01','黑色牛仔裤（女）',200.00,_binary '\0',72,'wJean01.png',29,'2023-12-11 13:44:20',29,'2023-12-11 13:44:29'),(59,'wHat01','帽子',200.00,_binary '\0',71,'wHat01.png',29,'2023-12-11 13:45:26',29,'2023-12-11 15:28:52'),(60,'wBag01','单肩斜挎包',800.00,_binary '\0',84,'wBag01.png',29,'2023-12-11 13:46:14',29,'2023-12-11 13:46:23'),(61,'wAcc02','眼镜',600.00,_binary '\0',68,'wAcc02.png',29,'2023-12-11 13:47:07',29,'2023-12-11 13:47:17'),(62,'wAcc01','项链',1000.00,_binary '\0',68,'wAcc01.png',29,'2023-12-11 13:47:54',29,'2023-12-11 13:48:05'),(64,'mTShirt02','男横条长袖T恤',218.00,_binary '',79,'mTShirt02.png',29,'2023-12-11 13:50:45',29,'2023-12-11 13:51:00'),(65,'mTShirt01','男LEE休闲T恤',128.00,_binary '',79,'mTShirt01.png',29,'2023-12-11 13:51:32',29,'2023-12-11 13:51:44'),(66,'mSweater01','男休闲毛衣',358.00,_binary '',78,'mSweater01.png',29,'2023-12-11 13:52:19',29,'2023-12-11 13:52:29'),(67,'mShoe02','男休闲运动鞋',290.00,_binary '',75,'mShoe02.png',29,'2023-12-11 13:53:05',29,'2023-12-11 13:53:16'),(68,'mShoe01','男休闲皮鞋',460.00,_binary '',75,'mShoe01.png',29,'2023-12-11 13:53:45',29,'2023-12-11 13:53:52'),(69,'mShirt02','男商务长袖衬衫',298.00,_binary '',74,'mShirt02.png',29,'2023-12-11 13:54:31',29,'2023-12-11 13:54:43'),(70,'mShirt01','男休闲衬衫',198.00,_binary '',74,'mShirt01.png',29,'2023-12-11 13:55:09',29,'2023-12-11 13:55:19'),(71,'mOutWear02','男休闲厚外套',700.00,_binary '',73,'mOutWear02.png',29,'2023-12-11 13:55:50',29,'2023-12-11 13:56:04');
/*!40000 ALTER TABLE `clothes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clothes_details`
--

DROP TABLE IF EXISTS `clothes_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clothes_details` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `user_id` bigint(20) NOT NULL COMMENT '用户id',
  `clothes_id` bigint(20) NOT NULL COMMENT '服装id',
  `priority` bigint(20) NOT NULL COMMENT '优先级',
  `category_id` bigint(20) DEFAULT NULL,
  `create_user` bigint(20) NOT NULL COMMENT '创建人ID',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_user` bigint(20) NOT NULL COMMENT '更新人ID',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `1` (`clothes_id`),
  KEY `2` (`user_id`),
  KEY `3` (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=184 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clothes_details`
--

LOCK TABLES `clothes_details` WRITE;
/*!40000 ALTER TABLE `clothes_details` DISABLE KEYS */;
INSERT INTO `clothes_details` VALUES (46,44,50,1,75,44,'2023-12-11 21:51:59',44,'2023-12-13 08:47:24'),(81,44,60,17,84,44,'2023-12-13 00:20:23',44,'2023-12-13 16:26:26'),(90,29,50,1,75,29,'2023-12-13 10:10:40',29,'2023-12-13 10:10:40'),(96,43,59,1,71,43,'2023-12-13 10:39:09',43,'2023-12-13 10:39:09'),(140,43,33,0,76,43,'2023-12-13 11:31:45',43,'2023-12-16 20:57:49'),(147,43,61,1,68,43,'2023-12-13 11:38:12',43,'2023-12-13 11:38:12'),(156,29,16,1,77,29,'2023-12-13 13:46:12',29,'2023-12-13 13:46:12'),(158,29,55,1,72,29,'2023-12-13 13:46:22',29,'2023-12-13 13:46:22'),(160,44,59,1,71,44,'2023-12-13 16:35:36',44,'2023-12-13 16:35:36'),(163,44,61,1,68,44,'2023-12-13 16:36:06',44,'2023-12-13 16:36:06'),(176,43,56,1,72,43,'2023-12-13 21:51:09',43,'2023-12-13 21:51:09'),(179,44,53,2,74,44,'2023-12-14 15:00:25',44,'2023-12-14 15:00:51'),(180,44,55,2,72,44,'2023-12-14 15:00:43',44,'2023-12-14 15:19:57'),(183,29,61,1,68,29,'2023-12-14 15:47:50',29,'2023-12-14 15:47:50');
/*!40000 ALTER TABLE `clothes_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `username` varchar(20) NOT NULL COMMENT '用户名称',
  `nickname` varchar(64) NOT NULL DEFAULT '' COMMENT '用户实名',
  `password` varchar(32) NOT NULL COMMENT '密码',
  `sex` bit(1) NOT NULL COMMENT '性别 0 女 1 男',
  `is_admin` bit(1) NOT NULL COMMENT ' 是否为管理员 0 否  1 是',
  `model` varchar(128) NOT NULL DEFAULT '' COMMENT '模型',
  `create_user` bigint(20) NOT NULL COMMENT '创建人ID',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_user` bigint(20) NOT NULL COMMENT '更新人ID',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='用户表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'hhhh','管理员1111','a906449d5769fa7361d7ecc6aa3f6d28',_binary '',_binary '','mheadA',1,'2023-11-26 15:00:57',29,'2023-12-14 15:46:26'),(26,'test','asdas','123abc',_binary '\0',_binary '','wheadB',0,'2023-11-27 22:11:47',43,'2023-12-05 14:17:43'),(29,'666666','管理员','e8da22bb5eaf08c2e434bfd17a1446a0',_binary '\0',_binary '','wheadA',0,'2023-11-28 20:24:49',29,'2023-12-14 15:46:16'),(30,'7777777','管理员','e8da22bb5eaf08c2e434bfd17a1446a0',_binary '',_binary '\0','mheadB',30,'2023-11-28 20:45:13',29,'2023-11-30 11:14:30'),(32,'yxxxxy','yxy','13b4941427a2ade9290e96a269f8c5d0',_binary '',_binary '\0','mheadB',0,'2023-11-29 11:07:12',0,'2023-11-29 11:07:12'),(34,'rmt','rrrrr','9137786d191c17909c8cc04c2b2d1a0c',_binary '\0',_binary '','wheadB',0,'2023-11-29 11:29:36',1,'2023-11-29 11:30:11'),(37,'test1','test111','197c38bec209d857ab00d8b2b0ab97b1',_binary '',_binary '','mheadB',0,'2023-11-29 14:21:19',1,'2023-11-29 14:23:10'),(43,'yxy','撒大苏打','a906449d5769fa7361d7ecc6aa3f6d28',_binary '',_binary '','mheadB',0,'2023-11-29 20:57:56',43,'2023-12-13 21:51:43'),(44,'test2','bieshanwo','4ebf3ac052c754abe7ae8ef057e924bf',_binary '\0',_binary '','wheadA',0,'2023-11-30 10:06:48',0,'2023-11-30 10:06:48'),(45,'test3','普通用户','4ebf3ac052c754abe7ae8ef057e924bf',_binary '',_binary '\0','mheadB',0,'2023-11-30 10:50:49',0,'2023-11-30 10:50:49'),(47,'999999999','普通用户','e8da22bb5eaf08c2e434bfd17a1446a0',_binary '',_binary '\0','mheadB',0,'2023-11-30 11:30:53',0,'2023-11-30 11:30:53'),(48,'yy','阿三大苏打','a906449d5769fa7361d7ecc6aa3f6d28',_binary '\0',_binary '\0','wheadB',0,'2023-12-01 21:55:46',0,'2023-12-01 21:55:46'),(49,'test111','xxsj','4ebf3ac052c754abe7ae8ef057e924bf',_binary '',_binary '\0','mheadA',0,'2023-12-01 22:23:20',0,'2023-12-01 22:23:20'),(50,'user','普通用户11','a906449d5769fa7361d7ecc6aa3f6d28',_binary '',_binary '\0','mheadB',0,'2023-12-04 11:21:52',50,'2023-12-06 10:45:53'),(51,'hqt','普通用户','e8da22bb5eaf08c2e434bfd17a1446a0',_binary '',_binary '\0','mheadB',0,'2023-12-04 16:53:42',0,'2023-12-04 16:53:42'),(52,'啊啊啊啊','23423432','a906449d5769fa7361d7ecc6aa3f6d28',_binary '\0',_binary '\0','wheadB',0,'2023-12-06 10:29:09',0,'2023-12-06 10:29:09'),(53,'wx','微醺','9cbf8a4dcb8e30682b927f352d6559a0',_binary '',_binary '','mheadA',0,'2023-12-06 10:30:46',53,'2023-12-06 11:48:46');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-12-16 20:59:53
