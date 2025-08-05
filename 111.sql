/*
 Navicat Premium Dump SQL

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 80042 (8.0.42)
 Source Host           : localhost:3306
 Source Schema         : 111

 Target Server Type    : MySQL
 Target Server Version : 80042 (8.0.42)
 File Encoding         : 65001

 Date: 22/06/2025 00:36:44
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for activity
-- ----------------------------
DROP TABLE IF EXISTS `activity`;
CREATE TABLE `activity`  (
  `activity_id` int NOT NULL COMMENT '活动编号',
  `registrationtime` datetime NULL DEFAULT NULL COMMENT '报名时间',
  `activitytime` datetime NULL DEFAULT NULL COMMENT '活动时间',
  `endtime` datetime NULL DEFAULT NULL COMMENT '结束时间',
  `organizer` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '组织者',
  `instructor` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '指导老师',
  `location` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '活动地点',
  `participantsnumber` int NULL DEFAULT 0 COMMENT '活动人数',
  `title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '活动标题',
  `level` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '活动级别',
  `category` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '活动类别',
  `limit` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '活动限制',
  `status` enum('审核中','筹备中','进行中','已结束') CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '审核中' COMMENT '活动状态',
  PRIMARY KEY (`activity_id`) USING BTREE,
  UNIQUE INDEX `idx_title_time`(`title` ASC, `activitytime` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE,
  INDEX `idx_category`(`category` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '活动' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of activity
-- ----------------------------
INSERT INTO `activity` VALUES (2025001, '2025-03-01 00:00:00', '2025-03-15 14:00:00', '2025-03-15 17:00:00', '极客编程社', NULL, NULL, 0, '2025编程挑战赛', NULL, NULL, NULL, '筹备中');
INSERT INTO `activity` VALUES (2025002, '2025-04-01 00:00:00', '2025-04-20 09:00:00', '2025-04-20 12:00:00', '晨曦篮球社', NULL, NULL, 0, '春季篮球联赛', NULL, NULL, NULL, '审核中');

-- ----------------------------
-- Table structure for activity_participation
-- ----------------------------
DROP TABLE IF EXISTS `activity_participation`;
CREATE TABLE `activity_participation`  (
  `activity_id2` int NOT NULL COMMENT '活动编号',
  `student_id1` int NOT NULL COMMENT '学号',
  `sign_in` enum('是','否') CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '否' COMMENT '是否签到',
  `sign_out` enum('是','否') CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '否' COMMENT '是否签退',
  PRIMARY KEY (`activity_id2`, `student_id1`) USING BTREE,
  INDEX `student_id1`(`student_id1` ASC) USING BTREE,
  CONSTRAINT `activity_id2` FOREIGN KEY (`activity_id2`) REFERENCES `activity` (`activity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `student_id1` FOREIGN KEY (`student_id1`) REFERENCES `student` (`student_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '活动参与表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of activity_participation
-- ----------------------------

-- ----------------------------
-- Table structure for activity_records
-- ----------------------------
DROP TABLE IF EXISTS `activity_records`;
CREATE TABLE `activity_records`  (
  `activity_id1` int NOT NULL COMMENT '活动编号',
  `fundingrecords` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '经费记录',
  `Feedback` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '活动反馈',
  PRIMARY KEY (`activity_id1`) USING BTREE,
  CONSTRAINT `activity_id1` FOREIGN KEY (`activity_id1`) REFERENCES `activity` (`activity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '活动记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of activity_records
-- ----------------------------

-- ----------------------------
-- Table structure for application_form
-- ----------------------------
DROP TABLE IF EXISTS `application_form`;
CREATE TABLE `application_form`  (
  `form_id` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '申请单ID',
  `applicant` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '申请人',
  `submitdate` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '提交日期',
  `Reviewstatus` enum('待审核','已通过','已驳回') CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '待审核' COMMENT '审核状态',
  `budget` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '申请预算',
  `venue_id` int NULL DEFAULT NULL COMMENT '申请场地ID',
  `clubname` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '社团名称',
  `jobnumber` int NULL DEFAULT NULL COMMENT '工号',
  `activity_id` int NULL DEFAULT NULL COMMENT '活动编号',
  PRIMARY KEY (`form_id`) USING BTREE,
  INDEX `jobnumber`(`jobnumber` ASC) USING BTREE,
  INDEX `activity_id`(`activity_id` ASC) USING BTREE,
  INDEX `clubname`(`clubname` ASC) USING BTREE,
  INDEX `venue_id`(`venue_id` ASC) USING BTREE,
  CONSTRAINT `activity_id` FOREIGN KEY (`activity_id`) REFERENCES `activity` (`activity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `clubname` FOREIGN KEY (`clubname`) REFERENCES `club` (`clubname`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `jobnumber` FOREIGN KEY (`jobnumber`) REFERENCES `approver` (`jobnumber`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `venue_id` FOREIGN KEY (`venue_id`) REFERENCES `venue` (`venue_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '活动申请单' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of application_form
-- ----------------------------

-- ----------------------------
-- Table structure for approver
-- ----------------------------
DROP TABLE IF EXISTS `approver`;
CREATE TABLE `approver`  (
  `jobnumber` int NOT NULL COMMENT '工号',
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '审批员姓名',
  `office` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '职务',
  `contact` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '联系方式',
  PRIMARY KEY (`jobnumber`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '审批员' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of approver
-- ----------------------------
INSERT INTO `approver` VALUES (1001, '陈老师', '团委书记', '13800138001');
INSERT INTO `approver` VALUES (1002, '林老师', '学生处主任', '13800138002');

-- ----------------------------
-- Table structure for blacklist
-- ----------------------------
DROP TABLE IF EXISTS `blacklist`;
CREATE TABLE `blacklist`  (
  `student_id` int NOT NULL COMMENT '学号',
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '姓名',
  `violationreason` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '违规原因',
  `violationtime` datetime NULL DEFAULT NULL COMMENT '违规时间',
  `release_time` datetime NULL DEFAULT NULL COMMENT '放出时间',
  `activity_id` int NULL DEFAULT NULL COMMENT '关联活动ID',
  PRIMARY KEY (`student_id`) USING BTREE,
  INDEX `fk_blacklist_activity`(`activity_id` ASC) USING BTREE,
  CONSTRAINT `fk_blacklist_activity` FOREIGN KEY (`activity_id`) REFERENCES `activity` (`activity_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `student_id` FOREIGN KEY (`student_id`) REFERENCES `student` (`student_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '黑名单' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of blacklist
-- ----------------------------

-- ----------------------------
-- Table structure for club
-- ----------------------------
DROP TABLE IF EXISTS `club`;
CREATE TABLE `club`  (
  `clubname` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '社团名称',
  `description` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL COMMENT '社团介绍',
  `level` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '社团级别',
  `category` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '社团类型',
  PRIMARY KEY (`clubname`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '社团' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of club
-- ----------------------------

-- ----------------------------
-- Table structure for club_member
-- ----------------------------
DROP TABLE IF EXISTS `club_member`;
CREATE TABLE `club_member`  (
  `leader` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '社团负责人',
  `officer` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '社团干事',
  PRIMARY KEY (`leader`, `officer`) USING BTREE,
  INDEX `leader`(`leader` ASC) USING BTREE,
  INDEX `officer`(`officer` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '社团成员' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of club_member
-- ----------------------------

-- ----------------------------
-- Table structure for club_member_relation
-- ----------------------------
DROP TABLE IF EXISTS `club_member_relation`;
CREATE TABLE `club_member_relation`  (
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '社团名称',
  `leader` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '社团负责人',
  `officer` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '社团干事',
  PRIMARY KEY (`name`, `leader`, `officer`) USING BTREE,
  INDEX `leader`(`leader` ASC) USING BTREE,
  INDEX `officer`(`officer` ASC) USING BTREE,
  CONSTRAINT `leader` FOREIGN KEY (`leader`) REFERENCES `club_member` (`leader`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `name` FOREIGN KEY (`name`) REFERENCES `club` (`clubname`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `officer` FOREIGN KEY (`officer`) REFERENCES `club_member` (`officer`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '社团成员关系表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of club_member_relation
-- ----------------------------

-- ----------------------------
-- Table structure for student
-- ----------------------------
DROP TABLE IF EXISTS `student`;
CREATE TABLE `student`  (
  `student_id` int NOT NULL COMMENT '学号',
  `avatar` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT 'default_avatar.jpg' COMMENT '头像',
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '姓名',
  `college` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '学院',
  `training_level` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '培养层次',
  `major` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '专业',
  `grade` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '年级',
  `class` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '班级',
  `ethnicity` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '民族',
  `political_outlook` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '政治面貌',
  `activity_record` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '活动记录',
  `on_blacklist` enum('是','否') CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '否' COMMENT '是否在黑名单内',
  PRIMARY KEY (`student_id`) USING BTREE,
  INDEX `idx_college`(`college` ASC) USING BTREE,
  INDEX `idx_major`(`major` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '学生' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of student
-- ----------------------------

-- ----------------------------
-- Table structure for venue
-- ----------------------------
DROP TABLE IF EXISTS `venue`;
CREATE TABLE `venue`  (
  `venue_id` int NOT NULL COMMENT '场地ID',
  `venue_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '场地名称',
  `location` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '位置',
  `capacity` int NULL DEFAULT NULL COMMENT '容量',
  `status` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '状态',
  PRIMARY KEY (`venue_id`) USING BTREE,
  UNIQUE INDEX `idx_venue_name`(`venue_name` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '场地' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of venue
-- ----------------------------

-- ----------------------------
-- View structure for v_activity_details_updatable
-- ----------------------------
DROP VIEW IF EXISTS `v_activity_details_updatable`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_activity_details_updatable` AS select `activity`.`activity_id` AS `activity_id`,`activity`.`title` AS `title`,`activity`.`activitytime` AS `activitytime`,`activity`.`endtime` AS `endtime`,`activity`.`location` AS `location`,`activity`.`organizer` AS `organizer`,`activity`.`status` AS `status`,`activity`.`participantsnumber` AS `participants_count` from `activity`;

-- ----------------------------
-- View structure for v_blacklist_students_updatable
-- ----------------------------
DROP VIEW IF EXISTS `v_blacklist_students_updatable`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_blacklist_students_updatable` AS select `b`.`student_id` AS `student_id`,`b`.`violationreason` AS `violationreason`,`b`.`violationtime` AS `violationtime`,`b`.`release_time` AS `release_time`,`b`.`activity_id` AS `activity_id` from `blacklist` `b`;

-- ----------------------------
-- View structure for v_club_basic_updatable
-- ----------------------------
DROP VIEW IF EXISTS `v_club_basic_updatable`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_club_basic_updatable` AS select `club`.`clubname` AS `clubname`,`club`.`description` AS `description`,`club`.`level` AS `level`,`club`.`category` AS `category` from `club`;

-- ----------------------------
-- View structure for v_student_basic_updatable
-- ----------------------------
DROP VIEW IF EXISTS `v_student_basic_updatable`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_student_basic_updatable` AS select `student`.`student_id` AS `student_id`,`student`.`name` AS `name`,`student`.`college` AS `college`,`student`.`major` AS `major`,`student`.`grade` AS `grade`,`student`.`class` AS `class`,`student`.`on_blacklist` AS `on_blacklist` from `student`;

-- ----------------------------
-- View structure for v_venue_basic_updatable
-- ----------------------------
DROP VIEW IF EXISTS `v_venue_basic_updatable`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_venue_basic_updatable` AS select `venue`.`venue_id` AS `venue_id`,`venue`.`venue_name` AS `venue_name`,`venue`.`location` AS `location`,`venue`.`capacity` AS `capacity`,`venue`.`status` AS `status` from `venue`;

-- ----------------------------
-- Triggers structure for table activity
-- ----------------------------
DROP TRIGGER IF EXISTS `validate_activity_time`;
delimiter ;;
CREATE TRIGGER `validate_activity_time` BEFORE INSERT ON `activity` FOR EACH ROW BEGIN
    IF NEW.`endtime` IS NOT NULL AND NEW.`activitytime` IS NOT NULL THEN
        IF NEW.`endtime` <= NEW.`activitytime` THEN
            SIGNAL SQLSTATE '45000' 
            SET MESSAGE_TEXT = '活动结束时间必须晚于开始时间';
        END IF;
    END IF;
    
    IF NEW.`activitytime` IS NOT NULL AND NEW.`registrationtime` IS NOT NULL THEN
        IF NEW.`activitytime` <= NEW.`registrationtime` THEN
            SIGNAL SQLSTATE '45001'
            SET MESSAGE_TEXT = '活动开始时间必须晚于报名时间';
        END IF;
    END IF;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table activity
-- ----------------------------
DROP TRIGGER IF EXISTS `tr_check_club_leader_activity`;
delimiter ;;
CREATE TRIGGER `tr_check_club_leader_activity` BEFORE UPDATE ON `activity` FOR EACH ROW BEGIN
    IF NOT (IS_SYSTEM_ADMIN() OR NEW.organizer = CURRENT_USER_CLUB()) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = '无权修改其他社团的活动';
    END IF;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table activity_participation
-- ----------------------------
DROP TRIGGER IF EXISTS `prevent_blacklisted_student`;
delimiter ;;
CREATE TRIGGER `prevent_blacklisted_student` BEFORE INSERT ON `activity_participation` FOR EACH ROW BEGIN
    DECLARE blacklist_status VARCHAR(2);
    SELECT `on_blacklist` INTO blacklist_status FROM `student` WHERE `student_id` = NEW.`student_id1`;
    IF blacklist_status = '是' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '该学生在黑名单中，无法参加活动';
    END IF;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table activity_participation
-- ----------------------------
DROP TRIGGER IF EXISTS `tr_check_participation`;
delimiter ;;
CREATE TRIGGER `tr_check_participation` BEFORE UPDATE ON `activity_participation` FOR EACH ROW BEGIN
    IF NEW.student_id1 != CURRENT_USER_ID() THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = '只能修改自己的参与记录';
    END IF;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table activity_participation
-- ----------------------------
DROP TRIGGER IF EXISTS `tr_check_student_participation`;
delimiter ;;
CREATE TRIGGER `tr_check_student_participation` BEFORE UPDATE ON `activity_participation` FOR EACH ROW BEGIN
    IF NOT (IS_SYSTEM_ADMIN() OR NEW.student_id1 = CURRENT_USER_ID()) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = '只能修改自己的参与记录';
    END IF;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table blacklist
-- ----------------------------
DROP TRIGGER IF EXISTS `update_blacklist_status`;
delimiter ;;
CREATE TRIGGER `update_blacklist_status` AFTER INSERT ON `blacklist` FOR EACH ROW BEGIN
    UPDATE `student` SET `on_blacklist` = '是' WHERE `student_id` = NEW.`student_id`;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table blacklist
-- ----------------------------
DROP TRIGGER IF EXISTS `remove_blacklist_status`;
delimiter ;;
CREATE TRIGGER `remove_blacklist_status` AFTER DELETE ON `blacklist` FOR EACH ROW BEGIN
    UPDATE `student` SET `on_blacklist` = '否' WHERE `student_id` = OLD.`student_id`;
END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
