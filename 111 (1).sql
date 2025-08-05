/*
Navicat MySQL Data Transfer

Source Server         : local
Source Server Version : 50728
Source Host           : localhost:3306
Source Database       : 111

Target Server Type    : MYSQL
Target Server Version : 50728
File Encoding         : 65001

Date: 2025-06-22 14:24:26
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for activity
-- ----------------------------
DROP TABLE IF EXISTS `activity`;
CREATE TABLE `activity` (
  `activity_id` int(11) NOT NULL COMMENT '活动编号',
  `registrationtime` datetime DEFAULT NULL COMMENT '报名时间',
  `activitytime` datetime DEFAULT NULL COMMENT '活动时间',
  `endtime` datetime DEFAULT NULL COMMENT '结束时间',
  `organizer` varchar(255) DEFAULT NULL COMMENT '组织者',
  `instructor` varchar(255) DEFAULT NULL COMMENT '指导老师',
  `location` varchar(255) DEFAULT NULL COMMENT '活动地点',
  `participantsnumber` int(11) DEFAULT '0' COMMENT '活动人数',
  `title` varchar(255) DEFAULT NULL COMMENT '活动标题',
  `level` varchar(255) DEFAULT NULL COMMENT '活动级别',
  `category` varchar(255) DEFAULT NULL COMMENT '活动类别',
  `limit` varchar(255) DEFAULT NULL COMMENT '活动限制',
  `status` enum('审核中','筹备中','进行中','已结束') DEFAULT '审核中' COMMENT '活动状态',
  PRIMARY KEY (`activity_id`) USING BTREE,
  UNIQUE KEY `idx_title_time` (`title`,`activitytime`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='活动';

-- ----------------------------
-- Records of activity
-- ----------------------------
INSERT INTO `activity` VALUES ('2025001', '2025-03-01 00:00:00', '2025-03-15 14:00:00', '2025-03-15 17:00:00', '极客编程社', '张教授', '第一教学楼101', '50', '2025编程挑战赛', '校级', '学术科技', '无', '筹备中');
INSERT INTO `activity` VALUES ('2025002', '2025-04-01 00:00:00', '2025-04-20 09:00:00', '2025-04-20 12:00:00', '晨曦篮球社', '李教练', '体育馆篮球场', '100', '春季篮球联赛', '院级', '体育竞技', '需体检证明', '审核中');
INSERT INTO `activity` VALUES ('2025003', '2025-05-01 00:00:00', '2025-05-15 19:00:00', '2025-05-15 21:00:00', '音乐爱好者协会', '王老师', '音乐厅', '60', '校园歌手大赛', '校级', '文化艺术', '无', '已结束');
INSERT INTO `activity` VALUES ('2025004', '2025-06-01 00:00:00', '2025-06-10 08:00:00', '2025-06-10 17:00:00', '极客编程社', '赵教授', '学生活动中心', '120', '黑客马拉松', '校级', '学术科技', '需编程基础', '已结束');

-- ----------------------------
-- Table structure for activity_participation
-- ----------------------------
DROP TABLE IF EXISTS `activity_participation`;
CREATE TABLE `activity_participation` (
  `activity_id2` int(11) NOT NULL COMMENT '活动编号',
  `student_id1` int(11) NOT NULL COMMENT '学号',
  `sign_in` enum('是','否') DEFAULT '否' COMMENT '是否签到',
  `sign_out` enum('是','否') DEFAULT '否' COMMENT '是否签退',
  PRIMARY KEY (`activity_id2`,`student_id1`) USING BTREE,
  KEY `student_id1` (`student_id1`) USING BTREE,
  CONSTRAINT `activity_id2` FOREIGN KEY (`activity_id2`) REFERENCES `activity` (`activity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `student_id1` FOREIGN KEY (`student_id1`) REFERENCES `student` (`student_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='活动参与表';

-- ----------------------------
-- Records of activity_participation
-- ----------------------------
INSERT INTO `activity_participation` VALUES ('2025001', '20230001', '是', '是');
INSERT INTO `activity_participation` VALUES ('2025001', '20230002', '是', '否');
INSERT INTO `activity_participation` VALUES ('2025002', '20230003', '是', '是');
INSERT INTO `activity_participation` VALUES ('2025002', '20230004', '否', '否');
INSERT INTO `activity_participation` VALUES ('2025003', '20230005', '是', '是');

-- ----------------------------
-- Table structure for activity_records
-- ----------------------------
DROP TABLE IF EXISTS `activity_records`;
CREATE TABLE `activity_records` (
  `activity_id1` int(11) NOT NULL COMMENT '活动编号',
  `fundingrecords` varchar(255) DEFAULT NULL COMMENT '经费记录',
  `Feedback` varchar(255) DEFAULT NULL COMMENT '活动反馈',
  PRIMARY KEY (`activity_id1`) USING BTREE,
  CONSTRAINT `activity_id1` FOREIGN KEY (`activity_id1`) REFERENCES `activity` (`activity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='活动记录';

-- ----------------------------
-- Records of activity_records
-- ----------------------------
INSERT INTO `activity_records` VALUES ('2025001', '总支出:5000元, 明细:场地费2000, 奖品3000', '参与度高, 反响良好');
INSERT INTO `activity_records` VALUES ('2025002', '总支出:3000元, 明细:场地费1000, 器材2000', '比赛激烈, 观众热情');
INSERT INTO `activity_records` VALUES ('2025003', '总支出:4000元, 明细:音响设备2000, 评委费用2000', '选手水平高, 现场氛围好');

-- ----------------------------
-- Table structure for application_form
-- ----------------------------
DROP TABLE IF EXISTS `application_form`;
CREATE TABLE `application_form` (
  `form_id` varchar(255) NOT NULL COMMENT '申请单ID',
  `applicant` varchar(255) NOT NULL COMMENT '申请人',
  `submitdate` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '提交日期',
  `Reviewstatus` enum('待审核','已通过','已驳回') DEFAULT '待审核' COMMENT '审核状态',
  `budget` varchar(255) NOT NULL COMMENT '申请预算',
  `venue_id` int(11) DEFAULT NULL COMMENT '申请场地ID',
  `clubname` varchar(255) DEFAULT NULL COMMENT '社团名称',
  `jobnumber` int(11) DEFAULT NULL COMMENT '工号',
  `activity_id` int(11) DEFAULT NULL COMMENT '活动编号',
  PRIMARY KEY (`form_id`) USING BTREE,
  KEY `jobnumber` (`jobnumber`) USING BTREE,
  KEY `activity_id` (`activity_id`) USING BTREE,
  KEY `clubname` (`clubname`) USING BTREE,
  KEY `venue_id` (`venue_id`) USING BTREE,
  CONSTRAINT `activity_id` FOREIGN KEY (`activity_id`) REFERENCES `activity` (`activity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `clubname` FOREIGN KEY (`clubname`) REFERENCES `club` (`clubname`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `jobnumber` FOREIGN KEY (`jobnumber`) REFERENCES `approver` (`jobnumber`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `venue_id` FOREIGN KEY (`venue_id`) REFERENCES `venue` (`venue_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='活动申请单';

-- ----------------------------
-- Records of application_form
-- ----------------------------
INSERT INTO `application_form` VALUES ('APP2025001', '20230001', '2025-02-20 10:00:00', '已通过', '5000', '1', '极客编程社', '1001', '2025001');
INSERT INTO `application_form` VALUES ('APP2025002', '20230003', '2025-03-25 14:30:00', '已通过', '3000', '2', '晨曦篮球社', '1002', '2025002');
INSERT INTO `application_form` VALUES ('APP2025003', '20230003', '2025-04-10 09:15:00', '待审核', '4000', '4', '音乐爱好者协会', '1001', '2025003');
INSERT INTO `application_form` VALUES ('APP2025004', '20230001', '2025-05-15 16:20:00', '已驳回', '6000', '3', '极客编程社', '1002', '2025004');

-- ----------------------------
-- Table structure for approver
-- ----------------------------
DROP TABLE IF EXISTS `approver`;
CREATE TABLE `approver` (
  `jobnumber` int(11) NOT NULL COMMENT '工号',
  `name` varchar(255) DEFAULT NULL COMMENT '审批员姓名',
  `office` varchar(255) DEFAULT NULL COMMENT '职务',
  `contact` varchar(20) DEFAULT NULL COMMENT '联系方式',
  PRIMARY KEY (`jobnumber`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='审批员';

-- ----------------------------
-- Records of approver
-- ----------------------------
INSERT INTO `approver` VALUES ('1001', '陈老师', '团委书记', '13800138001');
INSERT INTO `approver` VALUES ('1002', '林老师', '学生处主任', '13800138002');

-- ----------------------------
-- Table structure for blacklist
-- ----------------------------
DROP TABLE IF EXISTS `blacklist`;
CREATE TABLE `blacklist` (
  `student_id` int(11) NOT NULL COMMENT '学号',
  `name` varchar(255) DEFAULT NULL COMMENT '姓名',
  `violationreason` varchar(255) DEFAULT NULL COMMENT '违规原因',
  `violationtime` datetime DEFAULT NULL COMMENT '违规时间',
  `release_time` datetime DEFAULT NULL COMMENT '放出时间',
  `activity_id` int(11) DEFAULT NULL COMMENT '关联活动ID',
  PRIMARY KEY (`student_id`) USING BTREE,
  KEY `fk_blacklist_activity` (`activity_id`) USING BTREE,
  CONSTRAINT `fk_blacklist_activity` FOREIGN KEY (`activity_id`) REFERENCES `activity` (`activity_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `student_id` FOREIGN KEY (`student_id`) REFERENCES `student` (`student_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='黑名单';

-- ----------------------------
-- Records of blacklist
-- ----------------------------

-- ----------------------------
-- Table structure for club
-- ----------------------------
DROP TABLE IF EXISTS `club`;
CREATE TABLE `club` (
  `clubname` varchar(255) NOT NULL COMMENT '社团名称',
  `description` text COMMENT '社团介绍',
  `level` varchar(255) DEFAULT NULL COMMENT '社团级别',
  `category` varchar(255) DEFAULT NULL COMMENT '社团类型',
  PRIMARY KEY (`clubname`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='社团';

-- ----------------------------
-- Records of club
-- ----------------------------
INSERT INTO `club` VALUES ('晨曦篮球社', '篮球爱好者的聚集地', '院级', '体育竞技');
INSERT INTO `club` VALUES ('极客编程社', '专注于编程和技术交流的社团', '校级', '学术科技');
INSERT INTO `club` VALUES ('音乐爱好者协会', '音乐创作与表演社团', '校级', '文化艺术');

-- ----------------------------
-- Table structure for club_member
-- ----------------------------
DROP TABLE IF EXISTS `club_member`;
CREATE TABLE `club_member` (
  `leader` varchar(255) NOT NULL COMMENT '社团负责人',
  `officer` varchar(255) NOT NULL COMMENT '社团干事',
  PRIMARY KEY (`leader`,`officer`) USING BTREE,
  KEY `leader` (`leader`) USING BTREE,
  KEY `officer` (`officer`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='社团成员';

-- ----------------------------
-- Records of club_member
-- ----------------------------
INSERT INTO `club_member` VALUES ('20230001', '20230002');
INSERT INTO `club_member` VALUES ('20230001', '20230003');
INSERT INTO `club_member` VALUES ('20230003', '20230004');
INSERT INTO `club_member` VALUES ('20230003', '20230005');

-- ----------------------------
-- Table structure for club_member_relation
-- ----------------------------
DROP TABLE IF EXISTS `club_member_relation`;
CREATE TABLE `club_member_relation` (
  `name` varchar(255) NOT NULL COMMENT '社团名称',
  `leader` varchar(255) NOT NULL COMMENT '社团负责人',
  `officer` varchar(255) NOT NULL COMMENT '社团干事',
  PRIMARY KEY (`name`,`leader`,`officer`) USING BTREE,
  KEY `leader` (`leader`) USING BTREE,
  KEY `officer` (`officer`) USING BTREE,
  CONSTRAINT `leader` FOREIGN KEY (`leader`) REFERENCES `club_member` (`leader`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `name` FOREIGN KEY (`name`) REFERENCES `club` (`clubname`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `officer` FOREIGN KEY (`officer`) REFERENCES `club_member` (`officer`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='社团成员关系表';

-- ----------------------------
-- Records of club_member_relation
-- ----------------------------
INSERT INTO `club_member_relation` VALUES ('极客编程社', '20230001', '20230002');
INSERT INTO `club_member_relation` VALUES ('极客编程社', '20230001', '20230003');
INSERT INTO `club_member_relation` VALUES ('晨曦篮球社', '20230003', '20230004');
INSERT INTO `club_member_relation` VALUES ('音乐爱好者协会', '20230003', '20230005');

-- ----------------------------
-- Table structure for student
-- ----------------------------
DROP TABLE IF EXISTS `student`;
CREATE TABLE `student` (
  `student_id` int(11) NOT NULL COMMENT '学号',
  `avatar` varchar(255) DEFAULT 'default_avatar.jpg' COMMENT '头像',
  `name` varchar(255) DEFAULT NULL COMMENT '姓名',
  `college` varchar(255) DEFAULT NULL COMMENT '学院',
  `training_level` varchar(255) DEFAULT NULL COMMENT '培养层次',
  `major` varchar(255) DEFAULT NULL COMMENT '专业',
  `grade` varchar(255) DEFAULT NULL COMMENT '年级',
  `class` varchar(255) DEFAULT NULL COMMENT '班级',
  `ethnicity` varchar(255) DEFAULT NULL COMMENT '民族',
  `political_outlook` varchar(255) DEFAULT NULL COMMENT '政治面貌',
  `activity_record` varchar(255) DEFAULT NULL COMMENT '活动记录',
  `on_blacklist` enum('是','否') DEFAULT '否' COMMENT '是否在黑名单内',
  PRIMARY KEY (`student_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='学生';

-- ----------------------------
-- Records of student
-- ----------------------------
INSERT INTO `student` VALUES ('20230001', 'avatar1.jpg', '张三', '计算机学院', '本科', '计算机科学与技术', '2023', '1班', '汉族', '共青团员', null, '否');
INSERT INTO `student` VALUES ('20230002', 'avatar2.jpg', '李四', '信息学院', '本科', '软件工程', '2023', '2班', '回族', '群众', null, '否');
INSERT INTO `student` VALUES ('20230003', 'avatar3.jpg', '王五', '体育学院', '本科', '体育教育', '2023', '3班', '汉族', '共青团员', null, '否');
INSERT INTO `student` VALUES ('20230004', 'avatar4.jpg', '赵六', '艺术学院', '本科', '音乐表演', '2023', '1班', '蒙古族', '预备党员', null, '否');
INSERT INTO `student` VALUES ('20230005', 'avatar5.jpg', '钱七', '计算机学院', '研究生', '人工智能', '2023', '硕士1班', '汉族', '中共党员', null, '否');

-- ----------------------------
-- Table structure for venue
-- ----------------------------
DROP TABLE IF EXISTS `venue`;
CREATE TABLE `venue` (
  `venue_id` int(11) NOT NULL COMMENT '场地ID',
  `venue_name` varchar(255) DEFAULT NULL COMMENT '场地名称',
  `location` varchar(255) DEFAULT NULL COMMENT '位置',
  `capacity` int(11) DEFAULT NULL COMMENT '容量',
  `status` varchar(255) DEFAULT NULL COMMENT '状态',
  PRIMARY KEY (`venue_id`) USING BTREE,
  UNIQUE KEY `idx_venue_name` (`venue_name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='场地';

-- ----------------------------
-- Records of venue
-- ----------------------------
INSERT INTO `venue` VALUES ('1', '第一教学楼101', '第一教学楼', '100', '可用');
INSERT INTO `venue` VALUES ('2', '体育馆篮球场', '体育馆', '200', '可用');
INSERT INTO `venue` VALUES ('3', '学生活动中心', '校园东区', '150', '维修中');
INSERT INTO `venue` VALUES ('4', '音乐厅', '艺术学院大楼', '80', '可用');

-- ----------------------------
-- View structure for v_activity_details_updatable
-- ----------------------------
DROP VIEW IF EXISTS `v_activity_details_updatable`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_activity_details_updatable` AS select `activity`.`activity_id` AS `activity_id`,`activity`.`title` AS `title`,`activity`.`activitytime` AS `activitytime`,`activity`.`endtime` AS `endtime`,`activity`.`location` AS `location`,`activity`.`organizer` AS `organizer`,`activity`.`status` AS `status`,`activity`.`participantsnumber` AS `participants_count` from `activity` ;

-- ----------------------------
-- View structure for v_blacklist_students_updatable
-- ----------------------------
DROP VIEW IF EXISTS `v_blacklist_students_updatable`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_blacklist_students_updatable` AS select `b`.`student_id` AS `student_id`,`b`.`violationreason` AS `violationreason`,`b`.`violationtime` AS `violationtime`,`b`.`release_time` AS `release_time`,`b`.`activity_id` AS `activity_id` from `blacklist` `b` ;

-- ----------------------------
-- View structure for v_club_basic_updatable
-- ----------------------------
DROP VIEW IF EXISTS `v_club_basic_updatable`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_club_basic_updatable` AS select `club`.`clubname` AS `clubname`,`club`.`description` AS `description`,`club`.`level` AS `level`,`club`.`category` AS `category` from `club` ;

-- ----------------------------
-- View structure for v_student_basic_updatable
-- ----------------------------
DROP VIEW IF EXISTS `v_student_basic_updatable`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_student_basic_updatable` AS select `student`.`student_id` AS `student_id`,`student`.`name` AS `name`,`student`.`college` AS `college`,`student`.`major` AS `major`,`student`.`grade` AS `grade`,`student`.`class` AS `class`,`student`.`on_blacklist` AS `on_blacklist` from `student` ;

-- ----------------------------
-- View structure for v_venue_basic_updatable
-- ----------------------------
DROP VIEW IF EXISTS `v_venue_basic_updatable`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_venue_basic_updatable` AS select `venue`.`venue_id` AS `venue_id`,`venue`.`venue_name` AS `venue_name`,`venue`.`location` AS `location`,`venue`.`capacity` AS `capacity`,`venue`.`status` AS `status` from `venue` ;
DROP TRIGGER IF EXISTS `validate_activity_time`;
DELIMITER ;;
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
DELIMITER ;
DROP TRIGGER IF EXISTS `prevent_blacklisted_student`;
DELIMITER ;;
CREATE TRIGGER `prevent_blacklisted_student` BEFORE INSERT ON `activity_participation` FOR EACH ROW BEGIN
    DECLARE blacklist_status VARCHAR(2);
    SELECT `on_blacklist` INTO blacklist_status FROM `student` WHERE `student_id` = NEW.`student_id1`;
    IF blacklist_status = '是' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '该学生在黑名单中，无法参加活动';
    END IF;
END
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `update_blacklist_status`;
DELIMITER ;;
CREATE TRIGGER `update_blacklist_status` AFTER INSERT ON `blacklist` FOR EACH ROW BEGIN
    UPDATE `student` SET `on_blacklist` = '是' WHERE `student_id` = NEW.`student_id`;
END
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `remove_blacklist_status`;
DELIMITER ;;
CREATE TRIGGER `remove_blacklist_status` AFTER DELETE ON `blacklist` FOR EACH ROW BEGIN
    UPDATE `student` SET `on_blacklist` = '否' WHERE `student_id` = OLD.`student_id`;
END
;;
DELIMITER ;
