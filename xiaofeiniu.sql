SET NAMES UTF8;
DROP DATABASE IF EXISTS xiaofeiniu;
CREATE DATABASE xiaofeiniu CHARSET=UTF8;
USE xiaofeiniu;

-- 管理员信息表
CREATE TABLE xfn_admin(
    aid INT PRIMARY KEY AUTO_INCREMENT,              #管理员编号
    aname VARCHAR(32) UNIQUE,                        #管理员用户名
    apwd VARCHAR(64)                                 #管理员密码
);
INSERT INTO xfn_admin VALUES
(NULL,'admin',PASSWORD('123456')),
(NULL,'boss',PASSWORD('999999'));


-- 项目全局设置
CREATE TABLE xfn_settings(
    sid INT PRIMARY KEY AUTO_INCREMENT,              #编号
    appName VARCHAR(32),                             #应用/店家名称
    apiUrl VARCHAR(64),                              #数据API子系统地址
    adminUrl VARCHAR(64),                            #管理后台子系统地址
    appUrl VARCHAR(64),                              #顾客App子系统地址
    icp VARCHAR(64),                                 #系统备案号
    copyright VARCHAR(128)                           #系统版权声明
);
INSERT INTO xfn_settings VALUES
(NULL,'小肥牛','http://127.0.0.1:8090','http://127.0.0.1:8091','http://127.0.0.1:8092','京ICP备12003709号-3','Copyright © 北京达内金桥科技有限公司版权所有');


-- 桌台信息表
CREATE TABLE xfn_table(
    tid INT PRIMARY KEY AUTO_INCREMENT,                                 #桌台编号
    tname VARCHAR(32),                               #桌台昵称
    type VARCHAR(32),                                #桌台类型 如3-4人桌
    status INT                                       #当前状态
                                           #1-空闲 2-预定 3-占用 0-其他
);
INSERT INTO xfn_table VALUES
(NULL,'花开富贵','6-8人桌',1),
(NULL,'吉祥如意','4-6人桌',2),
(NULL,'否极泰来','10人桌',1),
(NULL,'心想事成','2人桌',0);


-- 桌台预定表
CREATE TABLE xfn_reservation(
    rid INT PRIMARY KEY AUTO_INCREMENT,  #信息编号
    contactName VARCHAR(32),             #联系人姓名
    phone VARCHAR(16),                   #联系人电话
    contactTime BIGINT,                  #联系时间,客户打电话
    dinnerTime BIGINT ,                   #用餐时间
    tableId INT,
    FOREIGN KEY(tableId) REFERENCES xfn_table(tid)
);
INSERT INTO xfn_reservation VALUES
(NULL,'dangdang','13852126526',1548392562685,1548392653655,1),
(NULL,'linwei','13852122654',1548392644559,1548392863655,2),
(NULL,'lindi','13852123568',1548392656559,1548392873655,3),
(NULL,'linpo','13852128518',1548392674559,1548392893655,4);


-- 菜品分类表
CREATE TABLE xfn_category(
    cid INT PRIMARY KEY AUTO_INCREMENT,            #类别编号
    cname VARCHAR(32)                          #类别名称
);
INSERT INTO xfn_category VALUES
(NULL,'肉类'),
(NULL,'海鲜河鲜'),
(NULL,'丸滑类'),
(NULL,'蔬菜豆制品'),
(NULL,'菌菇类');


-- 菜品信息表
CREATE TABLE xfn_dish(
    did INT PRIMARY KEY AUTO_INCREMENT,            #菜品编号，起始值100000
    title VARCHAR(32),                             #菜品名称，标题
    imgUrl VARCHAR(128),                           #图片地址
    price DECIMAL(6,2),                            #菜品价格
    detail VARCHAR(128),                           #详细描述信息
    categoryId INT,                                #所属类别的编号
    FOREIGN KEY(categoryId) REFERENCES xfn_category(cid)                  
);   
INSERT INTO xfn_dish VALUES
(100000,'草鱼片','rou/1001.jpg',35,'选鲜活草鱼，切出鱼片冷鲜保存。锅开后再煮1分钟左右即可食用。',1),
(NULL,'脆皮肠','rou/1002.jpg',20,'锅开后再煮3分钟左右即可食用。',1),
(NULL,'酥肉','rou/1003.jpg',25,'选用冷鲜五花肉，加上鸡蛋，淀粉等原料炸制，色泽黄亮，酥软醇香，肥而不腻。锅开后再煮3分钟左右即可食用。',1),
(NULL,'现炸酥肉(非清真)','rou/1004.jpg',25,'选用冷鲜五花肉，加上鸡蛋，淀粉等原料炸制，色泽黄亮，酥软醇香，肥而不腻。锅开后再煮1分钟左右即可食用，也可直接食用',1),
(NULL,'牛百叶','rou/1005.jpg',38,'毛肚切丝后，配以调味料腌制而成。锅开后再煮2分钟左右即可食用。',1),
(NULL,'腰花','rou/1006.jpg',36,'选用大型厂家冷鲜腰花，经过解冻、清洗、切片而成。锅开后涮30秒左右即可食用。',1),
(NULL,'猪脑花','rou/1007.jpg',40,'选用大型厂家冷鲜猪脑经过清洗，过水、撕膜而成。肉质细腻，锅开后再煮8分钟左右即可食用。',1),
(NULL,'午餐肉','rou/1008.jpg',23,'锅开后再煮2分钟左右即可食用。',1),
(NULL,'牛仔骨','rou/1009.jpg',45,'牛仔骨又称牛小排，选自资质合格的厂家生产配送。锅开后再煮5分钟左右即可食用。',1),
(NULL,'新西兰羊肉卷','rou/1010.jpg',28,'选用新西兰羔羊肉的前胸和肩胛为原料，在国内经过分割、压制成型，肥瘦均匀。锅开后涮30秒左右即可食用。',1),
(NULL,'捞派黄喉','rou/1011.jpg',36,'黄喉主要是猪和牛的大血管，以脆爽见长，是四川火锅中的经典菜式。捞派黄喉选用猪黄喉，相比牛黄喉，猪黄喉只有30cm可用，肉质比牛黄喉薄，口感更脆。
捞派黄喉，通过去筋膜、清水浸泡15小时以上，自然去除黄喉的血水和腥味。口感脆嫩弹牙，是川味火锅的经典菜式。',1),
(NULL,'千层毛肚','rou/1012.jpg',29,'选自牛的草肚，加入葱、姜、五香料一起煮熟后切片而成。五香味浓、耙软化渣。锅开后再煮3分钟左右即可食用。',1),
(NULL,'捞派脆脆毛肚','rou/1013.jpg',30,'选自牛的草肚，采用流水清洗、撕片等工艺，加入各种调味料腌制而成。口感脆嫩，锅开后再采用“七上八下”的方法涮15秒即可食用。',1),
(NULL,'捞派嫩羊肉','rou/1014.jpg',28,'羊后腿肉肉质紧实，肥肉少，以瘦肉为主；肉中夹筋，筋肉相连。肉质相比前腿肉更为细嫩，用途广，一般用于烧烤、酱制等用途。海底捞只选用生长周期达到6—8个月的草原羔羊，肉嫩筋少而膻味少。精选羔羊后腿肉，肉质紧实，瘦而不柴，再用红油腌制入味，肉香与油香充分融合，一口咬下去鲜嫩多汁、肉味十足。',1),
(NULL,'草原羔羊肉','rou/1015.jpg',28,'选自内蒙锡林郭勒大草原10月龄以下羔羊，经过排酸、切割、冷冻而成。锅开后涮30秒左右即可食用。',1),
(NULL,'澳洲肥牛(和牛)','rou/1016.jpg',46,'百分百澳洲牛肉的前胸部位，口感香嫩，汁浓味厚。锅开后涮30秒即可食用。',1),
(NULL,'捞派滑牛肉','rou/1017.jpg',40,'捞派滑牛肉使用的牛肉是大小米龙和嫩肩肉，是牛的后腿和前腿部位，最嫩的部位，形状像黄瓜，俗称：黄瓜条。每份滑牛都要经过解冻、去筋膜、分割、切片、腌制等9道复杂工序，口感滑嫩，久煮不老，是海底捞必点菜品。',1),
(NULL,'血旺','rou/1018.jpg',16,'选用资质合格的厂家配送。锅开后再煮5分钟左右即可食用。',1),
(NULL,'捞派肥牛','rou/1019.jpg',26,'肥牛是经过排酸处理后切成薄片的牛肉。排酸是指通过一定的温度、湿度、风速的环境下使牛的肌肉纤维发生变化，其口感更细腻、化渣。海底捞的捞派肥牛，精选谷饲100天以上的牛，自然块分割，肉味十足，久涮不淡。',1),
(NULL,'捞派鸭肠','rou/1020.jpg',18,'火锅三宝之一。鸭肠，具有韧性。口感脆爽有嚼劲，是火锅中经常用到的食材。
捞派鸭肠，选用资质和证件齐全的屠宰场鸭肠。经过掏肠、去大油、结石、抛肠、清洗、刀工去小油、清洗等步骤，确保每根鸭肠无杂物。捞派鸭肠口感自然脆爽，下锅涮食20-25秒左右即可食用。',1),
(NULL,'捞派毛肚','rou/1021.jpg',42,'选自牛的草肚，采用流水清洗、撕片等工艺，加入葱姜、料酒、花椒浸泡而成。口感脆嫩，锅开后涮10-15秒即可食用。',1),
(NULL,'羊排卷','rou/1022.jpg',34,'甄选12月龄以下放牧羔羊，以肥瘦相间的腹肉部位加工而成。口感细嫩化渣，锅开后涮30秒左右即可食用。',1),
(NULL,'手切羊肉','rou/1023.jpg',47,'甄选12月龄以下羔羊后腿以及羊霖，经过切配、装盘而成。锅开后再煮1分钟左右即可食用。',1),
(NULL,'火边子牛肉','rou/1024.jpg',48,'沿用四川自贡盐井的名菜火边子牛肉工艺，主要采用黄瓜条、多种炒香辣椒面、香辛料配制而成。颜色红亮，口味香辣刺激。锅开后再煮4分钟左右即可食用。',1),
(NULL,'捞派精品肥牛','rou/1025.jpg',48,'肥牛是经过排酸处理后切成薄片的牛肉。排酸是指通过一定的温度、湿度、风速的环境下使牛的肌肉纤维发生变化，其口感更细腻、化渣。
海底捞的精品肥牛，精选进口、自然生长谷饲100天以上的牛。每头牛只选用牛背部第1-6根肋骨上脑部位，一头牛产20公斤左右。经过排酸处理后，自然块分割，涮食时不易散，肉味浓，保证牛肉原有的香味。',1),
(NULL,'羊眼','rou/1026.jpg',18,'羊眼经过排酸、切割、冷冻而成。锅开后再煮5分钟左右即可食用。',1),
(NULL,'猪蹄','rou/1027.jpg',25,'猪蹄斩成小块，经过清洗，过水，用十余种符合国家食品安全的食材一起炖煮而成。锅开后再煮5分钟即可食用。',1),
(NULL,'捞派小鲜肉(非清真)','rou/1028.jpg',25,'猪蹄斩成小块，经过清洗，过水，用十余种符合国家食品安全的食材一起炖煮而成。锅开后再煮5分钟即可食用。',1),
(NULL,'捞派九尺鸭肠','rou/1029.jpg',18,'选自资质合格的供应商配送的鲜鸭肠。锅开后再“七上八下”涮食15秒即可食用。',1),
(NULL,'冻虾','haixian/2001.jpg',20,'将活虾冷冻而成。肉质脆嫩，锅开后再煮4分钟左右即可食用。',2),
(NULL,'鱼豆腐','haixian/2002.jpg',10,'选用优质鱼肉，配以佐料，搅打、蒸制而成。细嫩鲜滑，鱼香味浓。锅开后再煮2分钟左右即可食用。',2),
(NULL,'活虾','haixian/2003.jpg',22,'选自广东湛江、北海区域南美白虾，清洗干净装盘，锅开后再煮2分钟左右即可食用。',2),
(NULL,'青斑','haixian/2004.jpg',25,'经过宰杀、去内脏、清洗、装盘而成。锅开后鱼片煮1分钟左右，鱼头、鱼排煮4分钟即可食用。',2),
(NULL,'花鲢鱼头','haixian/2005.jpg',26,'选鲜活花鲢鱼，取头冷鲜保存。锅开后再煮5分钟左右即可食用。',2),
(NULL,'鱿鱼须','haixian/2006.jpg',28,'选用鱿鱼触角，速冻保鲜。锅开后再煮5分钟左右即可食用。',2),
(NULL,'大闸蟹','haixian/2007.jpg',18,'大闸蟹是一种经济蟹类，又称河蟹、毛蟹、清水蟹、大闸蟹或螃蟹，顾客可根据情况选择生、熟两种大闸蟹，生的大闸蟹，锅开后再煮8分钟左右即可食用。',2),
(NULL,'蛎蝗','haixian/2008.jpg',15,'经过宰杀、去内脏、清洗、装盘后上桌。锅开后再煮4-5分钟左右即可食用。',2),
(NULL,'大淡菜','haixian/2009.jpg',12,'经过宰杀、去内脏、清洗、装盘而成。锅开后再煮4分钟左右即可食用。',2),
(NULL,'北极贝','haixian/2010.jpg',19,'北极贝是源自北大西洋冰冷深海的一种贝类，肉质肥美，锅开后再煮4分钟左右即可食用。',2),
(NULL,'带鱼','haixian/2011.jpg',16,'带鱼又叫刀鱼、牙带鱼，其肉厚刺少，锅开后再煮5分钟左右即可食用。',2),
(NULL,'油蛤','haixian/2012.jpg',13,'经过宰杀、去内脏、清洗、装盘而成。锅开后再煮4分钟左右即可食用。',2),
(NULL,'黑头鱼','haixian/2013.jpg',18,'俗名猪嘴鱼，齿小而鳃耙多且长，门店经过宰杀、去内脏、清洗后装盘上桌，锅开后再煮6分钟左右即可食用。',2),
(NULL,'油条虾','haixian/2014.jpg',20,'油条炸制后，裹入虾滑而成。将油条的香味和虾滑的脆嫩结合在一起，锅开后再煮3分钟左右即可食用。',2),
(NULL,'深水虾','haixian/2015.jpg',22,'经过挑选、装盘而成。口感鲜嫩、食用方便，锅开后再煮2分钟左右即可食用。',2),
(NULL,'蟹味棒','haixian/2016.jpg',16,'锅开后再煮2分钟左右即可食用。',2),
(NULL,'美国红鱼(时价)','haixian/2017.jpg',10,'经过宰杀、去内脏、清洗、装盘后上桌。锅开后再煮4-5分钟左右即可食用。',2),
(NULL,'鱿鱼','haixian/2018.jpg',19,'选自资质合格的厂家，经过速冻保鲜配送。锅开后再煮5分钟左右即可食用。',2),
(NULL,'生蚝','haixian/2019.jpg',9,'经过宰杀、去内脏、清洗、装盘而成。海鲜味浓郁，锅开后再煮1分钟左右即可食用。',2),
(NULL,'扇贝','haixian/2020.jpg',8,'鲜活扇贝，餐前宰杀后上桌。锅开后再煮4分钟左右即可食用。',2),
(NULL,'象拔蚌','haixian/2021.jpg',7,'产自广西北海的象拔蚌，宰杀后上桌。锅开后再煮4分钟左右即可食用。',2),
(NULL,'捞派无刺巴沙鱼','haixian/2022.jpg',17,'巴沙鱼是东南亚淡水鱼品种。越南音译为"卡巴沙"(CABaSa)，意思是"三块脂肪鱼"，因为该鱼在生长过程中，腹腔积累有三块较大的油脂，约占体重的58%。
海底捞选用越南湄公河流域养殖的巴沙鱼。经工厂低温车间宰杀、快速去皮等工艺加工成鱼柳，包装速冻，再通过海底捞中央厨房加工腌制而成。巴沙鱼口味鲜嫩，且无刺无腥味，特别适合老人、小孩食用。',2),
(NULL,'罗非鱼','haixian/2023.jpg',18,'来自海拔1500米的云南高原深水罗非鱼，沐浴北回归线上的阳光，肉质鲜美嫩滑，余味悠长。',2),
(NULL,'捞派鱼饼','haixian/2024.jpg',19,'采用鱼肉制作，适合老人、孩子、女士，配上海鲜汁，鲜味浓郁，煮4分钟左右即可食用。',2),
(NULL,'草鱼头','haixian/2025.jpg',20,'精选鲜活草鱼，取头后冷鲜保存，锅开后再煮5分钟左右即可食用。',2),
(NULL,'黑鱼片','haixian/2026.jpg',22,'鲜活黑鱼取鱼片，调味后摆盘上桌。锅开后再煮1分钟左右即可食用。',2),
(NULL,'海鲜组合','haixian/2027.jpg',38,'由多种海鲜组合而成。下入锅中，开锅后再煮3分钟即可食用。',2),
(NULL,'明虾','haixian/2028.jpg',38,'经过清洗、装盘而成。锅开后再煮2分钟左右即可食用。',2),
(NULL,'旭伟蟹肉墨鱼滑','wanhua/3001.jpg',25,'将冰鲜墨鱼筒，经破碎、搅拌等工艺，再配以秘制调料，嵌入鲜毛蟹中。锅开后再煮4分钟左右即可食用。配上丸滑蘸碟，风味更突出。',3),
(NULL,'兆湛撒尿牛肉丸','wanhua/3002.jpg',28,'选用牛后腿部位牛霖，经过排酸、绞碎、搅打成的牛肉滑，捏成丸子后，里面裹入用老鸡、火腿等精心熬制的汤冻。锅开后浮起来再煮3分钟左右即可食用。配上丸滑蘸碟，风味更突出。撒尿牛丸中心汤汁温度较高，吃时小心被汤汁烫到。',3),
(NULL,'西式牛肉滑','wanhua/3003.jpg',38,'选用牛后腿部位，经过排酸、绞碎、搅打而成的牛肉滑，放入香菇、芹菜粒等原料，配以蛋黄。开锅后由服务员搅拌均匀、做成小丸下入，浮起来再煮3分钟左右即可食用。配上丸滑蘸碟，风味更突出。',3),
(NULL,'丸类组合','wanhua/3004.jpg',27,'由多种丸类组合而成。锅开后浮起来再煮3分钟左右即可食用。配上丸滑蘸碟，风味更突出。',3),
(NULL,'贝柱滑','wanhua/3005.jpg',17,'选用海湾贝肉打成滑，加上各种调料手工搅打起胶后再拼回贝壳。锅开后再煮3分钟左右即可食用，配上丸滑蘸碟，风味更突出。',3),
(NULL,'招牌虾滑','wanhua/3006.jpg',16,'精选湛江、北海区域出产的南美品种白虾虾仁，配以盐和淀粉等调料制作而成。虾肉含量越高，虾滑口感越纯正。相比纯虾肉，虾滑食用方便、入口爽滑鲜甜Q弹，海底捞独有的定制生产工艺，含肉量虾肉含量93%，出品装盘前手工摔打10次，是火锅中的经典食材。',3),
(NULL,'精品肉丸','wanhua/3007.jpg',15,'选自资质合格的厂家。锅开后浮起来后再煮3分钟左右即可食用。',3),
(NULL,'手工墨鱼丸','wanhua/3008.jpg',14,'墨鱼经破碎、搅拌等工艺，再配以秘制调料混合而成。锅开后再浮起来再煮3分钟即可食用。配上丸滑蘸碟，风味更突出。',3),
(NULL,'包心生菜','shucai/4001.jpg',6,'经过挑选、清洗、装盘而成。口感清香，锅开后再煮1分钟左右即可食用。',4),
(NULL,'蒿子秆（皇帝菜）','shucai/4002.jpg',9,'经过挑选、清洗、切配、装盘而成，锅开后再煮1分钟左右即可食用。',4),
(NULL,'竹笋','shucai/4003.jpg',8,'竹笋清洗后对剖切开，装盘，口感脆爽，锅开后再煮4分钟左右即可食用',4),
(NULL,'土豆','shucai/4004.jpg',10,'经过去泥、挑选、去皮、清洗、切配、装盘而成。锅开后再煮4分钟左右即可食用',4),
(NULL,'山药','shucai/4005.jpg',11,'经过去泥、挑选、去皮、清洗、切配、装盘而成。锅开后再煮3分钟左右即可食用。',4),
(NULL,'冬瓜','shucai/4006.jpg',13,'经过去泥、挑选、去皮、清洗、切配、装盘而成。锅开后再煮1分钟即可食用，不宜久煮，否则会煮溶',4),
(NULL,'白萝卜','shucai/4007.jpg',15,'经过去泥、挑选、去皮、清洗、切配、装盘而成。锅开后再煮3分钟左右即可食用',4),
(NULL,'红薯','shucai/4008.jpg',18,'经过去泥、挑选、去皮、清洗、切配、装盘而成。口感香甜，锅开后再煮4分钟左右即可食用',4),
(NULL,'海带','shucai/4009.jpg',14,'经过浸泡、挑选、清洗、切配、装盘而成。锅开后再煮3分钟左右即可食用',4),
(NULL,'白菜','shucai/4010.jpg',13,'经过挑选、清洗、切配、装盘而成，锅开后再煮2分钟左右即可食用',4),
(NULL,'大白菜','shucai/4011.jpg',13,'经过挑选、清洗、切配、装盘而成，锅开后再煮2分钟左右即可食用',4),
(NULL,'小白菜','shucai/4012.jpg',13,'经过挑选、清洗、切配、装盘而成。锅开后再煮2分钟左右即可食用',4),
(NULL,'香菜','shucai/4013.jpg',10,'是云南特色产品，装盘上桌即可。锅开后再煮2-3分钟左右即可食用',4),
(NULL,'茼蒿/蓬蒿菜','shucai/4014.jpg',10,'经过挑选、清洗、装盘而成。锅开后再煮1分钟左右即可食用',4),
(NULL,'薄荷','shucai/4015.jpg',9,'薄荷，土名叫“银丹草”，为唇形科植物，门店经过清洗后装盘上桌。锅开后再煮1-2分钟左右即可食用',4),
(NULL,'丝瓜','shucai/4016.jpg',8,'丝瓜清洗、去外皮后，切段摆盘而成。锅开后再煮3分钟左右即可使用',4),
(NULL,'娃娃菜','shucai/4017.jpg',9,'通过挑选、清洗、切配、装盘而成，易吸收锅底汤汁，锅开后再煮2分钟左右即可食用',4),
(NULL,'菠菜','shucai/4018.jpg',7,'经过挑选、清洗、切配、装盘而成。锅开后再煮1分钟左右即可食用',4),
(NULL,'豆苗','shucai/4019.jpg',10,'经过挑选、清洗、装盘而成。口感较脆，锅开后再煮1分钟左右即可食用',4),
(NULL,'油麦菜','shucai/4020.jpg',15,'经过挑选、清洗、切配、装盘而成。叶嫩杆脆，锅开后再煮1分钟左右即可食用',4),
(NULL,'芦笋','shucai/4021.jpg',18,'芦笋清新爽口、味道独特，锅开后煮4分钟即可食用',4),
(NULL,'豌豆尖','shucai/4022.jpg',19,'经过挑选、清洗、装盘而成。茎叶柔嫩，味美可口，锅开后再煮30秒左右即可食用',4),
(NULL,'散叶生菜','shucai/4023.jpg',10,'经过挑选、清洗、装盘而成。口感鲜嫩，锅开后再煮1分钟左右即可食用',4),
(NULL,'莴笋尖/凤尾','shucai/4024.jpg',11,'经过挑选、清洗、切配、装盘而成。锅开后再煮2分钟即可食用。',4),
(NULL,'油豆腐皮','shucai/4025.jpg',15,'切段、装盘，锅开后涮30秒左右即可食用。',4),
(NULL,'炸豆衣','shucai/4026.jpg',19,'鲜豆皮酿制，豆香味浓郁，锅开后涮30秒左右即可食用。',4),
(NULL,'青笋','shucai/4027.jpg',20,'经过挑选、清洗、切配、装盘而成。锅开后涮30秒即可食用',4),
(NULL,'手切笋','shucai/4028.jpg',22,'来自福建、安徽、湖北等地大山深处的毛竹笋，具有质嫩、色白、清脆、味甜的特性，竹林都在海拔 300-500 米以上的高山上，没有工业化污染。',4),
(NULL,'捞派豆花','shucai/4029.jpg',12,'采用优质大豆磨浆，经传统手工工艺压制而成。锅开后再煮5分钟左右即可食用。配上豆花蘸碟，口味更突出',4),
(NULL,'青笋','jungu/5001.jpg',18,'经过去泥、挑选、去皮、清洗、切配、装盘而成。口感清脆，锅开后再煮4分钟左右即可食用',5),
(NULL,'有机香菇','jungu/5002.jpg',22,'经过挑选、清洗、装盘而成。锅开后再煮2分钟左右即可食用',5),
(NULL,'杏鲍菇','jungu/5003.jpg',23,'经过挑选、清洗、切配、装盘而成。锅开后再煮3分钟左右即可食用',5),
(NULL,'椎茸','jungu/5004.jpg',25,'经过清洗、切配、装盘而成。锅开后再煮4分钟左右即可食用',5),
(NULL,'木耳','jungu/5005.jpg',27,'经过浸泡、挑选、装盘而成。锅开后再煮3分钟左右即可食用',5),
(NULL,'平菇','jungu/5006.jpg',29,'经过挑选、清洗、装盘而成。脆嫩而肥厚，锅开后再煮5分钟左右即可食用',5),
(NULL,'竹荪','jungu/5007.jpg',28,'野生竹荪，口感爽滑、脆嫩，开锅后煮3分钟左右即可食用',5),
(NULL,'香菇','jungu/5008.jpg',20,'经过挑选、清洗、切配、装盘而成。锅开后再煮5分钟左右即可食用',5),
(NULL,'金针菇','jungu/5009.jpg',16,'经过挑选、清洗、装盘而成。菌盖滑嫩、清脆，锅开后再煮2分钟左右即可食用。',5);





-- 订单表
CREATE TABLE xfn_order(
    oid INT PRIMARY KEY AUTO_INCREMENT,
    startTime BIGINT,
    endTime BIGINT,
    customerCount INT,
    tableId INT,
    FOREIGN KEY(tableId) REFERENCES xfn_table(tid)
);
INSERT INTO xfn_order VALUES
(1,1548404810420,1548405810420,3,1);

-- 订单详情表
CREATE TABLE xfn_order_detail(
    oid INT PRIMARY KEY AUTO_INCREMENT,       #订单编号
    dishId INT,                   #菜品编号
    dishCount INT,                            #菜品数量
    customerName VARCHAR(32),                 #点餐用户的称呼
    orderId INT,                              #订单编号，指明所属订单
    FOREIGN KEY(dishId) REFERENCES xfn_dish(did),
    FOREIGN KEY(orderId) REFERENCES xfn_order(oid)
);
INSERT INTO xfn_order_detail VALUES
(NULL,100001,1,'dingding',1);