/*
 Navicat Premium Data Transfer

 Source Server         : mysql
 Source Server Type    : MySQL
 Source Server Version : 80019
 Source Host           : localhost:3306
 Source Schema         : museum_db

 Target Server Type    : MySQL
 Target Server Version : 80019
 File Encoding         : 65001

 Date: 11/05/2023 21:40:07
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for ms_admin
-- ----------------------------
DROP TABLE IF EXISTS `ms_admin`;
CREATE TABLE `ms_admin`  (
  `id` int NOT NULL,
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ms_admin
-- ----------------------------
INSERT INTO `ms_admin` VALUES (1, 'admin', '123456');

-- ----------------------------
-- Table structure for ms_announcement
-- ----------------------------
DROP TABLE IF EXISTS `ms_announcement`;
CREATE TABLE `ms_announcement`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `date` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ms_announcement
-- ----------------------------
INSERT INTO `ms_announcement` VALUES (1, '通知', '这是一条通知消息', '2023/3/19');
INSERT INTO `ms_announcement` VALUES (2, '通知！！', '这是一条通知消息！！！！', '2023/3/19');
INSERT INTO `ms_announcement` VALUES (5, '通知！！！', '这是一条公告信息！！', '2023/4/15');
INSERT INTO `ms_announcement` VALUES (6, '通知', '<p>上线了富文本功能</p>', '2023/4/24');
INSERT INTO `ms_announcement` VALUES (7, '通知', '<p><a href=\"http://micefind.com\" rel=\"noopener noreferrer\" target=\"_blank\">这是一条带连接的公告消息</a></p>', '2023/4/24');

-- ----------------------------
-- Table structure for ms_cate
-- ----------------------------
DROP TABLE IF EXISTS `ms_cate`;
CREATE TABLE `ms_cate`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `catename` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ms_cate
-- ----------------------------
INSERT INTO `ms_cate` VALUES (4, '石刻');
INSERT INTO `ms_cate` VALUES (5, '壁画');
INSERT INTO `ms_cate` VALUES (6, '石器');
INSERT INTO `ms_cate` VALUES (7, '玉器');
INSERT INTO `ms_cate` VALUES (8, '陶器');
INSERT INTO `ms_cate` VALUES (9, '铜器');
INSERT INTO `ms_cate` VALUES (10, '铁器');
INSERT INTO `ms_cate` VALUES (11, '瓷器');
INSERT INTO `ms_cate` VALUES (12, '骨角牙器');
INSERT INTO `ms_cate` VALUES (13, '书法');
INSERT INTO `ms_cate` VALUES (14, '绘画');
INSERT INTO `ms_cate` VALUES (15, '油画');
INSERT INTO `ms_cate` VALUES (17, '金银器');
INSERT INTO `ms_cate` VALUES (18, '明星藏品');

-- ----------------------------
-- Table structure for ms_collection
-- ----------------------------
DROP TABLE IF EXISTS `ms_collection`;
CREATE TABLE `ms_collection`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `origin` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '起源时期',
  `cate_id` int NOT NULL,
  `describe` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `col_pic` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `base` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '基础信息',
  `view` int NULL DEFAULT NULL COMMENT '查看次数',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 89 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ms_collection
-- ----------------------------
INSERT INTO `ms_collection` VALUES (30, '跪坐奏乐陶俑（一组）', '考古发掘品', 8, '泥质红陶，模制。一组六件。为唐代宫廷器乐演奏的组合形式之一—“坐部伎”。绘白彩，面饱满，形 貌、服饰相似。头戴幞头，身穿圆领衫，腰系带。或 盘、或跪，分别执琵琶、横笛、排箫、箜篌、笙与拍板进行演奏。《旧唐书·音乐志》载：“高宗登极之后，宴享因隋旧制……后分为立、坐二部。”堂下立奏称“立部伎”，堂下坐奏为“坐部伎”。前者规模较大，后者人员虽少，但演奏水平高于前者。这组姿态端正、神情专注的乐俑，为研究唐代乐史提供了宝贵资料。', '\\uploads\\col_pic-1679211803932.jpg', '均高11厘米', 1);
INSERT INTO `ms_collection` VALUES (31, '后母戊鼎(青铜器)', '商周', 9, '后母戊鼎，1939年出土于河南安阳武官村，因鼎腹内壁上铸有“后母戊”三个字而得名后母戊鼎。后母戊鼎，鼎通体高133厘米、口长112厘米、口宽79.2厘米，重达832.84公斤，是商周时期青铜器的代表作，国家一级文物，现收藏于中国国家博物馆。后母戊鼎是世界迄今出土最大最重的青铜器，被誉为“青铜器之王”，享有“镇国之宝”的美誉。', '\\uploads\\col_pic-1679211995285.jpg', '高133厘米 重832.84公斤', 0);
INSERT INTO `ms_collection` VALUES (32, '四羊方尊', '商朝 中国国家博物馆', 9, '四羊方尊，商朝晚期青铜礼器，祭祀用品。1938年出土于湖南省宁乡市宁乡县黄材镇月山铺转耳仑的山腰上。收藏于中国国家博物馆。四羊方尊是中国仍存商代青铜方尊中最大的一件，其每边边长为52.4 厘米，高58.3厘米，重量34.5公斤，被史学界称为“臻于极致的青铜典范”，位列十大传世国宝之一。', '\\uploads\\col_pic-1679212170823.jpg', '长52.4 厘米 高58.3厘米 重34.5公斤', 0);
INSERT INTO `ms_collection` VALUES (33, '毛公鼎', '西周晚期 毛公 台北故宫博物院', 9, '毛公鼎，西周晚期毛公所铸青铜器，清道光二十三年(1843年)出土于陕西岐山(今宝鸡市岐山县)，现收藏于台北故宫博物院。鼎高53.8厘米，口径47.9厘米。圆形，二立耳，深腹外鼓，三蹄足，口沿饰环带状的重环纹，造型端庄稳重。鼎内铭文长达四百九十九字，记载了毛公衷心向周宣王为国献策之事，被誉为“抵得一篇尚书”。其书法乃成熟的西周金文风格，奇逸飞动，气象浑穆，笔意圆劲茂隽，结体方长。是研究西周晚年政治史的重要史料。', '\\uploads\\col_pic-1679212268802.jpg', '鼎高53.8厘米 口径47.9厘米', 1);
INSERT INTO `ms_collection` VALUES (34, '散氏盘', '西周晚期 台北故宫博物院', 9, '散氏盘，又称夨人盘，西周晚期青铜器，因铭文中有“散氏”字样而得名。清乾隆初年出土于陕西凤翔(今宝鸡市凤翔县)，现藏于台北故宫博物院。散氏盘，盘高20.6厘米，口径54.6厘。圆形，浅腹，双附耳，高圈足。腹饰夔纹，圈足饰兽面纹。内底铸有铭文19行、357字。记述地是夨人付给散氏田地之事，是研究西周土地制度的重要史料。散氏盘与毛公鼎、虢季子白盘并称为西周三大青铜器，与毛公鼎、大盂鼎、虢季子白盘并称为晚清四大国宝均以长篇铭文和精美的书法著称于世。', '\\uploads\\col_pic-1679212378130.jpg', '盘高20.6厘米 口径54.6厘米', 0);
INSERT INTO `ms_collection` VALUES (35, '越王勾践剑', '春秋晚期 越国', 9, '越王勾践剑，春秋晚期越国青铜器，1965年湖北省江陵县望山一号墓出土。越王勾践剑，剑通高55.7厘米，宽4.6厘米，柄长8.4厘米，重875克，极其锋利。因剑身上被镀上了一层含铬的金属而千年不锈，越王勾践剑被称为“天下第一剑”。', '\\uploads\\col_pic-1679212465897.jpg', '高55.7厘米 宽4.6厘米 柄长8.4厘米 重875克', 1);
INSERT INTO `ms_collection` VALUES (36, '西周大克鼎', '上海博物馆', 18, '西周大克鼎，1890年（清光绪十六年）陕西扶风（今宝鸡市扶风县法门镇任村）出土，收藏于上海博物馆。鼎高93.1厘米，重201.5千克 ，口径75.6厘米。大克鼎通高93.1厘米，口径75.6厘米，腹径74.9厘米，腹深43厘米，重201.5公斤。大克鼎与大盂鼎（现藏于中国国家博物馆）和毛公鼎（现藏于台北故宫博物院）并称为“海内青铜器三宝”。', '\\uploads\\col_pic-1679212567200.jpg', '鼎高93.1厘米 重201.5千克  口径75.6厘米', 33);
INSERT INTO `ms_collection` VALUES (37, '大盂鼎', '西周 炊器', 18, '大盂鼎，又称廿三祀盂鼎，西周炊器。1849年出土于陕西郿县礼村(今宝鸡市眉县)。1952年藏于上海博物馆，1959年转至中国历史博物馆(现中国国家博物馆)。鼎高101.9厘米，口径77.8厘米，重153.5千克。铭文291字，记载了周康王在宗周训诰盂之事。大盂鼎真实地反映了当时的社会状况，具有极高的史料价值。大盂鼎铭文是史家研究周代分封制和周王与臣属关系的重要史料，一向为史学家所重视。以书法成就而言，大盂鼎在成康时代当据首位，是西周早期金文书法的代表作。', '\\uploads\\col_pic-1679212649252.jpg', '高101.9厘米 口径77.8厘米 重153.5千克', 55);
INSERT INTO `ms_collection` VALUES (38, '马踏飞燕', '东汉', 18, '铜奔马，又称马踏飞燕，东汉时期文物。1969年出土于甘肃省武威市雷台汉墓，现藏甘肃省博物馆。“马踏飞燕”身高34.5厘米，身长45厘米，宽13厘米，自出土以来一直被视为中国古代高超铸造业的象征，马踏飞燕也是中国青铜艺术的奇葩。', '\\uploads\\col_pic-1679212731852.jpg', '高34.5厘米 身长45厘米 宽13厘米', 51);
INSERT INTO `ms_collection` VALUES (39, '红山文化女神像', '辽宁省考古研究所', 8, '红山文化女神像，1983年辽宁牛河梁红山文化“女神庙”出土，这是中国最早的女神像，现藏于辽宁省考古研究所。', '\\uploads\\col_pic-1679212850976.jpg', '无', 2);
INSERT INTO `ms_collection` VALUES (40, '刘胜金缕玉衣', '西汉 河北博物院', 18, '刘胜金缕玉衣，西汉时期文物。1968年5月出土于河北省满城县，收藏于河北博物院。这完整的金缕玉衣葬服，是闻名中外的首次重大发现，是十分珍贵的历史文物，堪称国宝。刘胜玉衣全长1.88米，共用玉片2498片，金丝约1100克，其外观和人体形状相同。在“玉衣”内还发现玉璧十八块，以及饭含，佩戴之物。', '\\uploads\\col_pic-1679212951927.jpg', '长1.88米 共用玉片2498片 金丝约1100克', 67);
INSERT INTO `ms_collection` VALUES (41, '皇后之玺”玉印', '西汉 陕西历史博物馆', 7, '“皇后之玺”玉印，西汉时期的文物，1968年出土于陕西省咸阳市韩家湾狼家沟村。西汉皇后之玺玉印，高2厘米，边长2.8厘米，现收藏于陕西历史博物馆。迄今为止，皇后之玺仍是我们发现的两汉时期等级最高、且唯一的一枚帝后玉玺，属于国家级文物。专家认为这方玉印的发现创造了两项全国之最：一是我国最早发现的皇后印玺；二是玉玺的主人是年代最早的皇后。', '\\uploads\\col_pic-1679213082346.jpg', '高2厘米 边长2.8厘米', 2);
INSERT INTO `ms_collection` VALUES (42, '玉琮王', '浙江省博物馆', 7, '新石器时代良渚文化玉琮，良渚文化玉琮之首。收藏于浙江省博物馆。此玉琮通高8.9厘米、上射径17.1—17.6厘米、下射径16.5—17.5厘米、孔外径5厘米、孔内径3.8厘米。是已发现的良渚玉琮中最大、最重、做工最精美的一件，被誉为“琮王”。', '\\uploads\\col_pic-1679213181586.jpg', '高8.9厘米', 0);
INSERT INTO `ms_collection` VALUES (44, '颜真卿祭侄文稿', '颜真卿', 13, '颜真卿祭侄文稿是颜真卿的书法帖本。原本为行草墨迹，纵28.2厘米，横72.3厘米，25行，共230字。这是颜真卿侄季明与其父杲卿于至德元年(756)间殉安史之乱后，颜真卿于乾元年(785)祭侄灵前，在极度悲愤中写下此稿。此稿意不书而在天机自动，以篆法入行，如熔金出冶，随地流走，一泻千里，时出遒劲，杂以流丽。如苏东坡所说“书法无意乃佳”，被人称为“天下第二行书”，与王羲之《兰亭序》媲美。', '\\uploads\\col_pic-1679213309398.jpg', '纵28.2厘米 横72.3厘米', 0);
INSERT INTO `ms_collection` VALUES (46, '苏轼《寒食帖》', '台北故宫博物院', 13, '《寒食帖》又名《黄州寒食诗帖》或《黄州寒食帖》。是苏轼撰诗并书，墨迹素笺本，横34.2厘米，纵18.9厘米，行书十七行，129字，现藏台北故宫博物院。因为有诸家的称赏赞誉，世人遂将《寒食帖》与东晋王羲之《兰亭序》、唐代颜真卿《祭侄稿》合称为“天下三大行书”，或单称《寒食帖》为“天下第三行书”。', '\\uploads\\col_pic-1679213849453.jpg', '横34.2厘米 纵18.9厘米', 0);
INSERT INTO `ms_collection` VALUES (47, '《平复帖》', '陆机 故宫博物院', 13, '《平复帖》为晋代陆机书法作品，牙色麻纸本墨迹，9行84字。《平复帖》书写于西晋，是传世年代最早的名家法帖，也是历史上第一件流传有序的法帖墨迹。有“法帖之祖”的美誉，见证了汉字流变。现藏故宫博物院。', '\\uploads\\col_pic-1679214338138.jpg', '9行84字', 0);
INSERT INTO `ms_collection` VALUES (48, '富春山居图', '元朝', 14, '富春山居图是元朝书画，画家黄公望为郑樗(无用师)所绘，用三、四年时间才画成，以浙江富春江为背景，全图用墨淡雅，山和水的布置疏密得当，墨色浓淡干湿并用，极富于变化，是黄公望的代表作，被称为“中国十大传世名画”之一。明朝末年传到收藏家吴洪裕手中，吴洪裕极为喜爱此画，甚至在临死前下令将此画焚烧殉葬，被吴洪裕的侄子从火中抢救出，但此时画已被烧成一大一小两段。较长的后段称《无用师卷》，现藏台北故宫博物院；前段称《剩山图》，现收藏于浙江省博物馆。', '\\uploads\\col_pic-1679214525388.jpg', ' ', 1);
INSERT INTO `ms_collection` VALUES (49, '韩滉《五牛图》', '唐代', 14, '韩滉《五牛图》，中国十大传世名画，是少数几件唐代传世纸绢画作品真迹之一，也是现存最古的纸本中国画，堪称“镇国之宝”，现存于北京故宫博物院。《五牛图》麻纸本，纵20.8厘米，横139.8厘米，无作者款印，有赵构、赵孟頫、孙弘、项元汴、弘历、金农等十四家题记。画中五头不同形态的牛，韩滉以淳朴的画风和精湛的艺术技巧，表现了唐代画牛所达到的最高水平。', '\\uploads\\col_pic-1679214592017.jpg', '纵20.8厘米 横139.8厘米', 0);
INSERT INTO `ms_collection` VALUES (50, '清明上河图', '北宋', 18, '清明上河图，中国十大传世名画之一。为北宋风俗画，北宋画家张择端仅见的存世精品，属国宝级文物，现藏于北京故宫博物院。清明上河图宽25.2厘米，长528厘米，绢本设色。这在中国乃至世界绘画史上都是独一无二的。在五米多长的画卷里，共绘了814个各色人物，牛、骡、驴等牲畜73匹，车、轿二十多辆，大小船只二十九艘。这幅镇院之宝出自五代南唐名画家顾闳中之手，经过千年的辗转，如今竟能完整无缺地保存下来，堪称奇迹。', '\\uploads\\col_pic-1679214667387.jpg', '宽25.2厘米 长528厘米', 44);
INSERT INTO `ms_collection` VALUES (51, '三彩骆驼载乐俑', '唐朝', 8, '三彩骆驼载乐俑为唐朝的文物，1959年出土于陕西省西安市西郊中堡村唐墓，通高58厘米，长41厘米。现收藏于陕西历史博物馆，堪称唐三彩中的极品。唐三彩骆驼载乐俑虽经地下埋葬一千三百多年，出土时仍光彩夺目，它是唯一一件被评定为国宝级文物的唐三彩。', '\\uploads\\col_pic-1679214797551.jpg', '高58厘米 长41厘米', 4);
INSERT INTO `ms_collection` VALUES (52, '鎏金舞马衔杯纹银壶', '唐朝', 17, '鎏金舞马衔杯纹银壶，唐朝的文物，1970年窖藏出土于陕西省西安市南郊何家村，高14.8厘米，口径2.3厘米。现收藏于陕西历史博物馆。马身和提梁、壶盖及“同心结”纹带均鎏金，使得银壶富丽堂皇，明快悦目。该壶构思巧妙，工艺精细，古今未见类同者，堪称国宝。', '\\uploads\\col_pic-1679214959981.jpg', '高14.8厘米 口径2.3厘米', 0);
INSERT INTO `ms_collection` VALUES (53, '石鼓文', '秦', 6, '石鼓文，秦刻石文字，因其刻石外形似鼓而得名。发现于唐初，共十枚，高约二尺，径约三尺，分别刻有大篆四言诗一首，共十首，计七百一十八字。关于石鼓文的确切年代，几千年来学者讨论不断，提出各种看法，至今还没有一个能够被大家都赞同的确定的结论。《石鼓文》是我国现存最早的石刻文字。也是古今书法家最为敬重的“圆笔书”圣典。原石现藏故宫博物院石鼓馆。', '\\uploads\\col_pic-1679215015407.jpg', '高约二尺 径约三尺', 0);
INSERT INTO `ms_collection` VALUES (54, '鹳鱼石斧图彩陶缸', '新石器时代', 18, '鹳鱼石斧图彩陶缸，1978年出土于河南省临汝县（今汝州市）阎村，新石器时代前期的葬具。为红陶砂质，高47厘米，口径32.7厘米，底径19.5厘米。器腹外壁的一侧就是著名的鹳鱼石斧图。图高37厘米，宽44厘米，约占缸体表面积的一半，画面真实生动、色彩和谐、古朴优美，极富意境，是迄今中国发现最早、面积最大的一幅陶画。收藏于中国国家博物馆。鹳鱼石斧图彩陶缸在2002年被列入中国首批禁止出国（境）展览文物珍贵文物之首。', '\\uploads\\col_pic-1679215067385.jpg', '高47厘米 口径32.7厘米 底径19.5厘米', 24);
INSERT INTO `ms_collection` VALUES (55, '商周太阳神鸟金饰', '商周', 17, '太阳神鸟金饰，商周时期文物，2001年2月25日出土于成都金沙遗址，现收藏于成都金沙遗址博物馆。太阳神鸟金饰，外径12.5 内径5.29 厚0.02（厘米）重20克，金箔的含金量高达94.2%，是用自然砂金加工而成。太阳神鸟金饰是古蜀国黄金工艺辉煌成就的代表，象征了三千年前的飞天梦。', '\\uploads\\col_pic-1679215119360.jpg', '外径12.5 内径5.29 厚0.02（厘米）重20克', 6);
INSERT INTO `ms_collection` VALUES (56, '传国玉玺', '秦', 7, '公元前221年,秦始皇灭六国统一中国后,将和氏璧雕琢为玉玺,命丞相李斯在其上篆\"受命於天,既寿永昌\"八个篆字,由玉工孙寿刻到传国玉玺上，方圆四寸,上纽交五龙。秦始皇宣布这枚玉玺可永远传世:得之者便是皇帝。于是,这枚玉玺便成了\"天子\"、\"权威\"的象征。', '\\uploads\\col_pic-1679215381918.jpg', '方圆四寸', 7);
INSERT INTO `ms_collection` VALUES (74, '后母戊鼎', '商朝', 18, '后母戊鼎因鼎腹内壁上铸有“后母戊”三字得名，是商王祭祀母亲的青铜重器。 后母戊鼎呈长方形，鼎高133厘米、口长110厘米、口宽79厘米，重832.84千克。鼎身雷纹为地，鼎身四周铸有精巧的盘龙纹和饕餮纹，雄伟庄严，工艺精巧，反映了商朝中国青铜铸造的超高工艺和艺术水平。\n后母戊鼎，是商周时期青铜文化的代表作，承载了数千年的悠悠岁月，是中国国家博物馆的镇馆之宝，是首批禁止出国（境）展览的文物。', '\\uploads\\col_pic-1681021373682.jpg', '高133厘米  重832.84千克', 34);
INSERT INTO `ms_collection` VALUES (80, '南朝石龟', '南朝', 4, '南朝石龟，是南朝的遗物，距今约1500年。这件石雕原存于南京市雨花台区铁心桥马家店的荒野。', '\\uploads\\col_pic-1682154484860.jpg', '南朝遗物 距今约1500年', 1);
INSERT INTO `ms_collection` VALUES (81, '宋代石羊', '宋代 南京', 4, '宋代石羊，这是南京一带所发现的唯一宋代石羊圆雕艺术石刻。\n石羊高1米，长1.20米，卧姿，神形兼备。', '\\uploads\\col_pic-1682155087839.jpg', '高1米 长1.20米', 1);
INSERT INTO `ms_collection` VALUES (82, '澧泉井碑', '明代', 4, '明神乐观“澧泉井碑”，立于永乐四年，\n明代洪武、建文、永乐三朝到天坛祭天时取用净水之井，仅存六角井栏、澧泉井碑等物。\n原保存在天坛新村江苏冶金机械厂内，2000年迁移于白马石刻公园内保护。', '\\uploads\\col_pic-1682155212050.jpg', '不详', 0);
INSERT INTO `ms_collection` VALUES (83, '二柱一间牌坊', '清代', 4, '牌坊柱间横以额坊，额坊上雕刻有精美的花纹。牌坊多见四柱三间或二柱一间。\n这座清代牌坊为二柱一间式，结构较为简洁，但额坊上的雕刻颇为精细。', '\\uploads\\col_pic-1682155321564.jpg', '不详', 0);
INSERT INTO `ms_collection` VALUES (84, '宋代神道石刻文臣', '宋代', 4, '宋代神道石刻文臣，原存南京市雨花台区铁心桥乡马家店。\n\n', '\\uploads\\col_pic-1682155383383.jpg', '不详', 0);
INSERT INTO `ms_collection` VALUES (85, '敦煌飞天', '敦煌', 5, '敦煌壁画飞天系列', '\\uploads\\col_pic-1682155647676.jpg', '敦煌壁画', 3);
INSERT INTO `ms_collection` VALUES (86, '伊朗陶碗', '公元前2800年—前2400年', 8, '伊朗陶碗，公元前2800年—前2400年；伊朗国家博物馆镇馆之宝之一', '\\uploads\\col_pic-1682342897917.jpg', '伊朗国家博物馆镇馆之宝', 27);
INSERT INTO `ms_collection` VALUES (87, '网格纹陶瓶', '约公元前3500年—前3000年', 8, '原始先民们因受到“被火烧过的泥土变得坚硬且有型”现象的启发，开始有意识地用泥土制作他们想要的器物并放置于火中烧制，人类最早的有意识制作的物品——陶器就这样诞生了。', '\\uploads\\col_pic-1682342943687.jpg', '中国甘肃定西市博物馆藏', 15);
INSERT INTO `ms_collection` VALUES (88, '小口尖底陶瓶', '约公元前5000年—前3000年', 8, '早期（新石器时期）的陶器主要是日用器皿，如水罐、杯碗、盆钵等。后人按用途将其分为如下几大类：1.汲器；2.炊器；3.饮器；4.食器；5.盛贮器；6.其它杂器等。', '\\uploads\\col_pic-1682342998353.jpg', '中国国家博物馆藏', 23);
INSERT INTO `ms_collection` VALUES (89, '炊器', '约公元前2500年—前2000年', 8, '炊器：顾名思义就是用来做饭的器具。如罐、鼎、鬲（li）、釜、甑（zeng）、灶等。如上图中陶鬲，在其足下燃火可煮食物。（陶鬲，约公元前2500年—前2000年；中国国家博物馆藏）', '\\uploads\\col_pic-1682343057199.jpg', '中国国家博物馆藏', 15);

-- ----------------------------
-- Table structure for ms_feedback
-- ----------------------------
DROP TABLE IF EXISTS `ms_feedback`;
CREATE TABLE `ms_feedback`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NULL DEFAULT NULL,
  `content` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `user_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `timestamp` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ms_feedback
-- ----------------------------
INSERT INTO `ms_feedback` VALUES (1, 5, '这是一条反馈信息', 'lisi', '2023/4/15');
INSERT INTO `ms_feedback` VALUES (2, 5, '这是一条反馈信息', 'lisi', '2023/4/15');
INSERT INTO `ms_feedback` VALUES (3, 5, '这是一条反馈信息', 'lisi', '2023/4/15');
INSERT INTO `ms_feedback` VALUES (4, 5, '这是一条反馈信息', 'lisi', '2023/4/15');
INSERT INTO `ms_feedback` VALUES (5, 5, '这是一条反馈信息', 'lisi', '2023/4/15');
INSERT INTO `ms_feedback` VALUES (6, 5, '这是一条反馈信息', 'lisi', '2023/4/15');
INSERT INTO `ms_feedback` VALUES (7, 5, '这是一条反馈信息', 'lisi', '2023/4/15');
INSERT INTO `ms_feedback` VALUES (8, 5, '这是一条反馈信息', 'lisi', '2023/4/15');
INSERT INTO `ms_feedback` VALUES (9, 5, '这是一条反馈信息', 'lisi', '2023/4/15');
INSERT INTO `ms_feedback` VALUES (10, 5, '这是一条反馈信息', 'lisi', '2023/4/15');
INSERT INTO `ms_feedback` VALUES (11, 5, '这是一条反馈信息', 'lisi', '2023/4/15');
INSERT INTO `ms_feedback` VALUES (12, 5, '这是一条反馈信息', 'lisi', '2023/4/15');
INSERT INTO `ms_feedback` VALUES (13, 5, '999', 'lisi', '2023/4/16');
INSERT INTO `ms_feedback` VALUES (14, 16, '图片有水印', 'aaa', '2023/4/16');
INSERT INTO `ms_feedback` VALUES (15, 17, '藏品信息太简单了，详细一点就好了', '大角牛', '2023/4/16');
INSERT INTO `ms_feedback` VALUES (16, 15, '希望加入3D展示', 'ddd', '2023/4/19');
INSERT INTO `ms_feedback` VALUES (17, 19, '希望加入藏品3d模型', 'user', '2023/4/22');

-- ----------------------------
-- Table structure for ms_slideshow
-- ----------------------------
DROP TABLE IF EXISTS `ms_slideshow`;
CREATE TABLE `ms_slideshow`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `pic_src` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ms_slideshow
-- ----------------------------
INSERT INTO `ms_slideshow` VALUES (1, '/uploads/col_pic-1681623225501.jpg');
INSERT INTO `ms_slideshow` VALUES (2, '/uploads/col_pic-1681623348646.jpg');
INSERT INTO `ms_slideshow` VALUES (3, '/uploads/col_pic-1681623438892.jpg');

-- ----------------------------
-- Table structure for ms_user
-- ----------------------------
DROP TABLE IF EXISTS `ms_user`;
CREATE TABLE `ms_user`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `date` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '注册时间',
  `address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `mobile` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `state` int NOT NULL COMMENT '用户状态，默认 0 正常',
  `nickname` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ms_user
-- ----------------------------
INSERT INTO `ms_user` VALUES (5, 'lisi', '111111', '2023/3/17', NULL, '13108962743', 1, '李四四');
INSERT INTO `ms_user` VALUES (6, 'jsj', '111111', '2023/3/17', NULL, '18225456688', 1, '柯尼卡');
INSERT INTO `ms_user` VALUES (7, 'admin', '123456', '2023/3/20', NULL, '13108962745', 0, '用户1');
INSERT INTO `ms_user` VALUES (8, 'user2', '111111', '2023/3/20', NULL, '13155553216', 1, '用户1');
INSERT INTO `ms_user` VALUES (9, 'zsan', '111111', '2023/3/20', NULL, '18223334567', 0, '张三');
INSERT INTO `ms_user` VALUES (10, 'dfaf', '4444444', '2023/3/20', NULL, '13525674215', 0, '卡西莫多');
INSERT INTO `ms_user` VALUES (11, 'user5', '5555555', '2023/3/20', NULL, '18233564151', 0, '用户5');
INSERT INTO `ms_user` VALUES (12, 'admin2', '111111', '2023/4/8', NULL, '', 0, '超级管理员');
INSERT INTO `ms_user` VALUES (14, '蜘蛛侠', '111111', '2023/4/9', NULL, '13109562547', 0, '猪猪侠');
INSERT INTO `ms_user` VALUES (15, 'ddd', '111111', '2023/4/9', NULL, NULL, 0, NULL);
INSERT INTO `ms_user` VALUES (16, 'aaa', '111111', '2023/4/16', NULL, NULL, 0, NULL);
INSERT INTO `ms_user` VALUES (17, '大角牛', '111111', '2023/4/16', NULL, NULL, 0, NULL);
INSERT INTO `ms_user` VALUES (18, '猪猪侠', '111111', '2023/4/19', NULL, NULL, 0, NULL);
INSERT INTO `ms_user` VALUES (19, 'user', '111111', '2023/4/22', NULL, NULL, 0, NULL);

SET FOREIGN_KEY_CHECKS = 1;
