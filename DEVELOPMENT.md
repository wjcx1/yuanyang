# 开发指南

## 项目设置

### 环境要求
- Java 11+
- MySQL 8.0+
- Tomcat 9.0.97
- Maven 3.x
- IntelliJ IDEA 2026.1.3
- DBeaver（数据库管理工具）

### 初始化步骤

1. **克隆项目**
   ```bash
   git clone https://github.com/wjcx1/yuanyang.git
   cd yuanyang
   ```

2. **创建数据库**
   - 打开 DBeaver
   - 连接到 MySQL
   - 执行 `sql/init.sql` 脚本

3. **配置数据库连接**
   - 编辑 `src/main/resources/properties/db.properties`
   - 修改数据库用户名和密码

4. **在 IntelliJ IDEA 中打开项目**
   - File → Open → 选择项目目录
   - 等待 Maven 依赖下载完成

5. **构建项目**
   ```bash
   mvn clean install
   ```

6. **配置 Tomcat 服务器**
   - Run → Edit Configurations
   - 点击 "+"，选择 "Tomcat Server Local"
   - 设置 Tomcat home 目录
   - 部署 War exploded
   - 设置应用上下文为 "/"

7. **运行项目**
   - Run → Run 'Tomcat 9.0.97'
   - 访问 http://localhost:8080

## 项目结构

```
src/
├── main/
│   ├── java/com/yuanyang/
│   │   ├── controller/      # 控制器层
│   │   ├── service/         # 业务逻辑层
│   │   ├── dao/             # 数据访问层
│   │   ├── model/           # 实体类
│   │   └── util/            # 工具类
│   ├── resources/
│   │   ├── spring/          # Spring 配置
│   │   ├── mapper/          # MyBatis 映射文件
│   │   └── properties/      # 属性文件
│   └── webapp/
│       └── WEB-INF/
│           └── views/       # JSP 视图
└── test/                    # 测试代码
```

## 开发规范

### Java 命名规范

- **包名**：全小写，如 `com.yuanyang.controller`
- **类名**：首字母大写，如 `UserController`
- **方法名**：首字母小写，如 `getUserList()`
- **常量名**：全大写，下划线分隔，如 `USER_ID`
- **变量名**：首字母小写，如 `userName`

### 分层架构

#### Controller 层（控制器层）
- 处理 HTTP 请求
- 验证输入参数
- 调用 Service 层
- 返回 JSON 或视图

#### Service 层（业务逻辑层）
- 实现业务逻辑
- 事务管理
- 调用 DAO 层
- 异常处理

#### DAO 层（数据访问层）
- MyBatis 接口
- 数据库操作
- SQL 映射文件

#### Model 层（实体类）
- 对应数据库表结构
- 包含 getter/setter 方法
- 实现 Serializable 接口

## 常见问题

### Q: 数据库连接失败怎么办？
A: 检查以下几点：
- MySQL 服务是否启动
- 检查 `db.properties` 中的连接信息
- 检查数据库用户名和密码是否正确

### Q: Maven 依赖下载缓慢？
A: 修改 Maven 配置文件 `settings.xml`，添加国内镜像源

### Q: 如何调试代码？
A: 在代码中设置断点，然后使用 Debug 模式运行项目

### Q: 如何查看数据库的实时数据？
A: 使用 DBeaver 连接数据库，查看表数据
