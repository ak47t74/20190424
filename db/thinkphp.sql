/*
 Navicat Premium Data Transfer

 Source Server         : MySQL
 Source Server Type    : MySQL
 Source Server Version : 50722
 Source Schema         : thinkphp

 Target Server Type    : MySQL
 Target Server Version : 50722
 File Encoding         : 65001

 Date: 24/04/2019 09:23:17
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for books
-- ----------------------------
DROP TABLE IF EXISTS `books`;
CREATE TABLE `books`  (
  `bid` int(10) NOT NULL AUTO_INCREMENT COMMENT '流水編號，關聯章節資料表對應欄位',
  `bname` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '書籍名稱',
  `bcover` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '書籍封面',
  `b_description` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '書籍簡介',
  `b_cost` int(10) NOT NULL DEFAULT 0,
  PRIMARY KEY (`bid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of books
-- ----------------------------
INSERT INTO `books` VALUES (1, 'ThinkPHP 3.0', 'http://iwvv.com/rkgthjdflgkhdfglhre.jpg', 'thinkphp 3.0 description', 0);
INSERT INTO `books` VALUES (2, 'ThinkPHP 4.0', 'http://iwvv.com/ytoiypgdopfjgopdi.jpg', 'thinkphp 4.0 description', 0);
INSERT INTO `books` VALUES (3, 'ThinkPHP 5.0', 'http://iwvv.com/sdfpgojkdfpgojkdf.jpg', 'thinkphp 5.0 description', 0);
INSERT INTO `books` VALUES (4, 'ThinkPHP 6.0', 'http://iwvv.com/qdfpgojkdfpgojkdo.jpg', 'thinkphp 6.0 description', 0);
INSERT INTO `books` VALUES (5, 'ThinkPHP 7.0', 'http://iwvv.com/ghtpgojkdfpgojkdg.jpg', 'thinkphp 7.0 description', 0);
INSERT INTO `books` VALUES (6, 'ThinkPHP 8.0', 'http://iwvv.com/iytpgojkdfpgojkdg.jpg', 'thinkphp 8.0 description', 0);

-- ----------------------------
-- Table structure for chapter
-- ----------------------------
DROP TABLE IF EXISTS `chapter`;
CREATE TABLE `chapter`  (
  `cid` int(10) NOT NULL AUTO_INCREMENT COMMENT '流水編號',
  `c_order` int(3) NOT NULL COMMENT '章節排序',
  `bid` int(10) NOT NULL COMMENT '對應的書籍bid，外部索引控制',
  `c_title` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '章節名稱',
  `c_cover` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '章節封面圖',
  `c_description` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '章節簡介',
  `c_cost` int(10) NULL DEFAULT NULL COMMENT '章節售價',
  PRIMARY KEY (`cid`) USING BTREE,
  INDEX `bid`(`bid`) USING BTREE,
  CONSTRAINT `book_id` FOREIGN KEY (`bid`) REFERENCES `books` (`bid`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 37 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of chapter
-- ----------------------------
INSERT INTO `chapter` VALUES (1, 1, 1, '序言', 'http://iwvv.com/aaaaaaaa.jpg', 'ThinkPHP是一個免費開源的，快速、簡單的面向對象的輕量級PHP開發框架，是為了敏捷WEB應用開發和簡化企業應用開發而誕生的。 ThinkPHP從誕生以來一直秉承簡潔實用的設計原則，在保持出色的性能和至簡的代碼的同時，也注重易用性。遵循Apache2開源許可協議發布，意味著你可以免費使用ThinkPHP，甚至允許把你基於ThinkPHP開發的應用開源或商業產品發布/銷售', 0);
INSERT INTO `chapter` VALUES (2, 2, 1, '基礎', 'http://iwvv.com/bbbbbbb.jpg', '下載最新版框架後，解壓縮到web目錄下面，可以看到初始的目錄結構如下', 0);
INSERT INTO `chapter` VALUES (3, 3, 1, '架構', 'http://iwvv.com/ccccccc.jpg', 'MVC是一個設計模式，它強制性的使應用程序的輸入、處理和輸出分開。使用MVC應用程序被分成三個核心部件：模型（M）、視圖（V）、控制器（C），它們各自處理自己的任務。', 0);
INSERT INTO `chapter` VALUES (4, 4, 1, '配置', 'http://iwvv.com/ddddddd.jpg', '對於有些簡單的應用，你無需配置任何配置文件，而對於復雜的要求，你還可以擴展自己的獨立配置文件', 10000);
INSERT INTO `chapter` VALUES (5, 5, 1, '路由', 'http://iwvv.com/eeeeeee.jpg', '路由的作用是簡化URL訪問地址，並根據定義的路由類型做出正確的解析。', 10);
INSERT INTO `chapter` VALUES (6, 6, 1, '控制器', 'http://iwvv.com/fffffff.jpg', 'ThinkPHP V5.0的控制器定義比較靈活，可以無需繼承任何的基礎類，也可以繼承官方封裝的 think Controller類或者其他的控制器類', 10);
INSERT INTO `chapter` VALUES (7, 1, 2, '序言', 'http://iwvv.com/aaaaaaaa.jpg', 'ThinkPHP是一個免費開源的，快速、簡單的面向對象的輕量級PHP開發框架，是為了敏捷WEB應用開發和簡化企業應用開發而誕生的。 ThinkPHP從誕生以來一直秉承簡潔實用的設計原則，在保持出色的性能和至簡的代碼的同時，也注重易用性。遵循Apache2開源許可協議發布，意味著你可以免費使用ThinkPHP，甚至允許把你基於ThinkPHP開發的應用開源或商業產品發布/銷售', 0);
INSERT INTO `chapter` VALUES (8, 2, 2, '基礎', 'http://iwvv.com/bbbbbbb.jpg', '下載最新版框架後，解壓縮到web目錄下面，可以看到初始的目錄結構如下', 0);
INSERT INTO `chapter` VALUES (9, 3, 2, '架構', 'http://iwvv.com/ccccccc.jpg', 'MVC是一個設計模式，它強制性的使應用程序的輸入、處理和輸出分開。使用MVC應用程序被分成三個核心部件：模型（M）、視圖（V）、控制器（C），它們各自處理自己的任務。', 0);
INSERT INTO `chapter` VALUES (10, 4, 2, '配置', 'http://iwvv.com/ddddddd.jpg', '對於有些簡單的應用，你無需配置任何配置文件，而對於復雜的要求，你還可以擴展自己的獨立配置文件', 10);
INSERT INTO `chapter` VALUES (11, 5, 2, '路由', 'http://iwvv.com/eeeeeee.jpg', '路由的作用是簡化URL訪問地址，並根據定義的路由類型做出正確的解析。', 10);
INSERT INTO `chapter` VALUES (12, 6, 2, '控制器', 'http://iwvv.com/fffffff.jpg', 'ThinkPHP V5.0的控制器定義比較靈活，可以無需繼承任何的基礎類，也可以繼承官方封裝的 think Controller類或者其他的控制器類', 10);
INSERT INTO `chapter` VALUES (13, 1, 3, '序言', 'http://iwvv.com/aaaaaaaa.jpg', 'ThinkPHP是一個免費開源的，快速、簡單的面向對象的輕量級PHP開發框架，是為了敏捷WEB應用開發和簡化企業應用開發而誕生的。 ThinkPHP從誕生以來一直秉承簡潔實用的設計原則，在保持出色的性能和至簡的代碼的同時，也注重易用性。遵循Apache2開源許可協議發布，意味著你可以免費使用ThinkPHP，甚至允許把你基於ThinkPHP開發的應用開源或商業產品發布/銷售', 0);
INSERT INTO `chapter` VALUES (14, 2, 3, '基礎', 'http://iwvv.com/bbbbbbb.jpg', '下載最新版框架後，解壓縮到web目錄下面，可以看到初始的目錄結構如下', 0);
INSERT INTO `chapter` VALUES (15, 3, 3, '架構', 'http://iwvv.com/ccccccc.jpg', 'MVC是一個設計模式，它強制性的使應用程序的輸入、處理和輸出分開。使用MVC應用程序被分成三個核心部件：模型（M）、視圖（V）、控制器（C），它們各自處理自己的任務。', 0);
INSERT INTO `chapter` VALUES (16, 4, 3, '配置', 'http://iwvv.com/ddddddd.jpg', '對於有些簡單的應用，你無需配置任何配置文件，而對於復雜的要求，你還可以擴展自己的獨立配置文件', 10);
INSERT INTO `chapter` VALUES (17, 5, 3, '路由', 'http://iwvv.com/eeeeeee.jpg', '路由的作用是簡化URL訪問地址，並根據定義的路由類型做出正確的解析。', 10);
INSERT INTO `chapter` VALUES (18, 6, 3, '控制器', 'http://iwvv.com/fffffff.jpg', 'ThinkPHP V5.0的控制器定義比較靈活，可以無需繼承任何的基礎類，也可以繼承官方封裝的 think Controller類或者其他的控制器類', 10);
INSERT INTO `chapter` VALUES (19, 1, 4, '序言', 'http://iwvv.com/aaaaaaaa.jpg', 'ThinkPHP是一個免費開源的，快速、簡單的面向對象的輕量級PHP開發框架，是為了敏捷WEB應用開發和簡化企業應用開發而誕生的。 ThinkPHP從誕生以來一直秉承簡潔實用的設計原則，在保持出色的性能和至簡的代碼的同時，也注重易用性。遵循Apache2開源許可協議發布，意味著你可以免費使用ThinkPHP，甚至允許把你基於ThinkPHP開發的應用開源或商業產品發布/銷售', 0);
INSERT INTO `chapter` VALUES (20, 2, 4, '基礎', 'http://iwvv.com/bbbbbbb.jpg', '下載最新版框架後，解壓縮到web目錄下面，可以看到初始的目錄結構如下', 0);
INSERT INTO `chapter` VALUES (21, 3, 4, '架構', 'http://iwvv.com/ccccccc.jpg', 'MVC是一個設計模式，它強制性的使應用程序的輸入、處理和輸出分開。使用MVC應用程序被分成三個核心部件：模型（M）、視圖（V）、控制器（C），它們各自處理自己的任務。', 0);
INSERT INTO `chapter` VALUES (22, 4, 4, '配置', 'http://iwvv.com/ddddddd.jpg', '對於有些簡單的應用，你無需配置任何配置文件，而對於復雜的要求，你還可以擴展自己的獨立配置文件', 10);
INSERT INTO `chapter` VALUES (23, 5, 4, '路由', 'http://iwvv.com/eeeeeee.jpg', '路由的作用是簡化URL訪問地址，並根據定義的路由類型做出正確的解析。', 10);
INSERT INTO `chapter` VALUES (24, 6, 4, '控制器', 'http://iwvv.com/fffffff.jpg', 'ThinkPHP V5.0的控制器定義比較靈活，可以無需繼承任何的基礎類，也可以繼承官方封裝的 think Controller類或者其他的控制器類', 10);
INSERT INTO `chapter` VALUES (25, 1, 5, '序言', 'http://iwvv.com/aaaaaaaa.jpg', 'ThinkPHP是一個免費開源的，快速、簡單的面向對象的輕量級PHP開發框架，是為了敏捷WEB應用開發和簡化企業應用開發而誕生的。 ThinkPHP從誕生以來一直秉承簡潔實用的設計原則，在保持出色的性能和至簡的代碼的同時，也注重易用性。遵循Apache2開源許可協議發布，意味著你可以免費使用ThinkPHP，甚至允許把你基於ThinkPHP開發的應用開源或商業產品發布/銷售', 0);
INSERT INTO `chapter` VALUES (26, 2, 5, '基礎', 'http://iwvv.com/bbbbbbb.jpg', '下載最新版框架後，解壓縮到web目錄下面，可以看到初始的目錄結構如下', 0);
INSERT INTO `chapter` VALUES (27, 3, 5, '架構', 'http://iwvv.com/ccccccc.jpg', 'MVC是一個設計模式，它強制性的使應用程序的輸入、處理和輸出分開。使用MVC應用程序被分成三個核心部件：模型（M）、視圖（V）、控制器（C），它們各自處理自己的任務。', 0);
INSERT INTO `chapter` VALUES (28, 4, 5, '配置', 'http://iwvv.com/ddddddd.jpg', '對於有些簡單的應用，你無需配置任何配置文件，而對於復雜的要求，你還可以擴展自己的獨立配置文件', 10);
INSERT INTO `chapter` VALUES (29, 5, 5, '路由', 'http://iwvv.com/eeeeeee.jpg', '路由的作用是簡化URL訪問地址，並根據定義的路由類型做出正確的解析。', 10);
INSERT INTO `chapter` VALUES (30, 6, 5, '控制器', 'http://iwvv.com/fffffff.jpg', 'ThinkPHP V5.0的控制器定義比較靈活，可以無需繼承任何的基礎類，也可以繼承官方封裝的 think Controller類或者其他的控制器類', 10);
INSERT INTO `chapter` VALUES (31, 1, 6, '序言', 'http://iwvv.com/aaaaaaaa.jpg', 'ThinkPHP是一個免費開源的，快速、簡單的面向對象的輕量級PHP開發框架，是為了敏捷WEB應用開發和簡化企業應用開發而誕生的。 ThinkPHP從誕生以來一直秉承簡潔實用的設計原則，在保持出色的性能和至簡的代碼的同時，也注重易用性。遵循Apache2開源許可協議發布，意味著你可以免費使用ThinkPHP，甚至允許把你基於ThinkPHP開發的應用開源或商業產品發布/銷售', 0);
INSERT INTO `chapter` VALUES (32, 2, 6, '基礎', 'http://iwvv.com/bbbbbbb.jpg', '下載最新版框架後，解壓縮到web目錄下面，可以看到初始的目錄結構如下', 0);
INSERT INTO `chapter` VALUES (33, 3, 6, '架構', 'http://iwvv.com/ccccccc.jpg', 'MVC是一個設計模式，它強制性的使應用程序的輸入、處理和輸出分開。使用MVC應用程序被分成三個核心部件：模型（M）、視圖（V）、控制器（C），它們各自處理自己的任務。', 0);
INSERT INTO `chapter` VALUES (34, 4, 6, '配置', 'http://iwvv.com/ddddddd.jpg', '對於有些簡單的應用，你無需配置任何配置文件，而對於復雜的要求，你還可以擴展自己的獨立配置文件', 10);
INSERT INTO `chapter` VALUES (35, 5, 6, '路由', 'http://iwvv.com/eeeeeee.jpg', '路由的作用是簡化URL訪問地址，並根據定義的路由類型做出正確的解析。', 10);
INSERT INTO `chapter` VALUES (36, 6, 6, '控制器', 'http://iwvv.com/fffffff.jpg', 'ThinkPHP V5.0的控制器定義比較靈活，可以無需繼承任何的基礎類，也可以繼承官方封裝的 think Controller類或者其他的控制器類', 10);

-- ----------------------------
-- Table structure for favorites
-- ----------------------------
DROP TABLE IF EXISTS `favorites`;
CREATE TABLE `favorites`  (
  `fid` int(10) NOT NULL AUTO_INCREMENT COMMENT '流水編號',
  `email` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '會員帳號',
  `bid` int(10) NOT NULL COMMENT '書籍編號',
  `cid` int(10) NOT NULL COMMENT '章節邊號',
  `jointime` int(10) NOT NULL COMMENT '加入時間',
  PRIMARY KEY (`fid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for member
-- ----------------------------
DROP TABLE IF EXISTS `member`;
CREATE TABLE `member`  (
  `id` int(15) NOT NULL AUTO_INCREMENT COMMENT '流水編號',
  `email` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '會員帳號',
  `password` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '使用者密碼',
  `emailcheck` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'y' COMMENT '郵件是否驗證，DEMO階段預設Y',
  `bean` decimal(7, 2) NOT NULL DEFAULT 0.00 COMMENT '會員餘額',
  PRIMARY KEY (`id`, `email`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for payment_records
-- ----------------------------
DROP TABLE IF EXISTS `payment_records`;
CREATE TABLE `payment_records`  (
  `pid` int(10) NOT NULL AUTO_INCREMENT COMMENT '流水編號',
  `payment_no` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '訂單編號',
  `item_name` char(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '商品名稱',
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '會員帳號',
  `amount` decimal(7, 2) NOT NULL COMMENT '金額',
  `payment_time` int(10) NOT NULL COMMENT '充值時間',
  PRIMARY KEY (`pid`, `payment_no`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
