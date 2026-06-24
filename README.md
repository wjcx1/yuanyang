# 远洋百货供应链管理系统

## 项目简介

远洋百货供应链管理系统是一个基于 **Spring MVC + MySQL** 的企业级供应链管理解决方案，用于管理百货中心的整个供应链流程。

## 系统功能模块

### 核心模块

1. **系统登录** - 用户身份验证和权限管理
2. **用户管理** - 用户信息的增删改查
3. **商品管理** - 商品信息的增删改查
4. **订单管理** - 订单信息的增删改查
5. **新闻管理** - 新闻信息的增删改查
6. **供应商管理** - 供应商信息的增删改查
7. **采购订单管理** - 采购订单的增删改查

## 技术栈

| 技术 | 版本 |
|------|------|
| Java | 11 |
| Spring Framework | 5.3.27 |
| Spring MVC | 5.3.27 |
| MySQL | 8.0.33 |
| MyBatis | 3.5.13 |
| Tomcat | 9.0.97 |
| Maven | 3.x |
| IDE | IntelliJ IDEA 2026.1.3 |

## 项目结构

```
yuanyang/
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   └── com/yuanyang/
│   │   │       ├── controller/        # 控制器层
│   │   │       ├── service/           # 业务逻辑层
│   │   │       ├── dao/               # 数据访问层
│   │   │       ├── model/             # 实体类
│   │   │       ├── util/              # 工具类
│   │   │       └── config/            # 配置类
│   │   ├── resources/
│   │   │   ├── spring/                # Spring 配置文件
│   │   │   ├── mapper/                # MyBatis 映射文件
│   │   │   ├── properties/            # 属性文件
│   │   │   └── logback.xml            # 日志配置
│   │   └── webapp/
│   │       ├── WEB-INF/
│   │       │   └── web.xml
│   │       └── views/                 # JSP 视图
│   └── test/                          # 测试文件
├── sql/                               # 数据库脚本
├── docs/                              # 项目文档
├── pom.xml                            # Maven 配置
└── README.md
```

## 快速开始

### 环境要求

- Java 11+
- MySQL 8.0+
- Tomcat 9.0.97
- Maven 3.x
- IntelliJ IDEA 2026.1.3
- DBeaver（数据库管理工具）

### 安装步骤

1. **克隆项目**
   ```bash
   git clone https://github.com/wjcx1/yuanyang.git
   cd yuanyang
   ```

2. **配置数据库**
   - 使用 DBeaver 打开 MySQL 连接
   - 执行 `sql/init.sql` 脚本创建数据库和表
   - 修改 `src/main/resources/properties/db.properties` 中的数据库连接信息

3. **构建项目**
   ```bash
   mvn clean install
   ```

4. **部署到 Tomcat**
   - 将生成的 `target/supply-chain-system.war` 复制到 `Tomcat/webapps/` 目录
   - 启动 Tomcat：`bin/startup.sh` (Linux/Mac) 或 `bin/startup.bat` (Windows)
   - 访问：http://localhost:8080

### 使用 Maven 启动

```bash
mvn tomcat7:run
```

## 数据库设计

### 主要表结构

- **users** - 用户表
- **products** - 商品表
- **orders** - 订单表
- **news** - 新闻表
- **suppliers** - 供应商表
- **purchase_orders** - 采购订单表

详见 `sql/init.sql`

## 开发规范

### 代码风格

- Java 命名规范：驼峰命名法
- 包名：全小写
- 类名：首字母大写
- 方法名：首字母小写
- 常量名：全大写，下划线分隔

### 分层架构

- **Controller 层**：处理 HTTP 请求，调用 Service 层
- **Service 层**：业务逻辑处理，调用 DAO 层
- **DAO 层**：数据库操作，使用 MyBatis
- **Model 层**：实体类，对应数据库表

## 常见问题

### Q: 如何连接 MySQL 数据库？
A: 修改 `src/main/resources/properties/db.properties` 文件中的连接信息

### Q: 如何添加新的模块？
A: 按照分层架构在对应目录创建 Controller、Service、DAO、Model 类

### Q: 如何运行测试？
A: 执行 `mvn test` 命令

## 贡献指南

1. Fork 本项目
2. 创建新分支 (`git checkout -b feature/新功能`)
3. 提交更改 (`git commit -m '添加新功能'`)
4. 推送到分支 (`git push origin feature/新功能`)
5. 创建 Pull Request

## 许可证

MIT License

---

**项目创建时间**：2026年6月24日
**维护者**：WJCX1