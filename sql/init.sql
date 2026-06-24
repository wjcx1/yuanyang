-- 远洋百货供应链管理系统 数据库脚本
-- 创建数据库和所有表

-- 创建数据库
CREATE DATABASE IF NOT EXISTS yuanyang CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE yuanyang;

-- 1. 用户表
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY COMMENT '用户ID',
    username VARCHAR(50) NOT NULL UNIQUE COMMENT '用户名',
    password VARCHAR(255) NOT NULL COMMENT '密码（加密后）',
    email VARCHAR(100) COMMENT '邮箱',
    phone VARCHAR(20) COMMENT '电话',
    real_name VARCHAR(50) COMMENT '真实姓名',
    gender ENUM('M', 'F', 'Unknown') DEFAULT 'Unknown' COMMENT '性别',
    role VARCHAR(50) NOT NULL COMMENT '角色（admin/manager/user）',
    department VARCHAR(50) COMMENT '部门',
    status ENUM('active', 'inactive', 'locked') DEFAULT 'active' COMMENT '账户状态',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    remark VARCHAR(255) COMMENT '备注',
    INDEX idx_username (username),
    INDEX idx_role (role),
    INDEX idx_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户表';

-- 2. 商品表
CREATE TABLE IF NOT EXISTS products (
    id INT AUTO_INCREMENT PRIMARY KEY COMMENT '商品ID',
    product_code VARCHAR(50) NOT NULL UNIQUE COMMENT '商品编码',
    product_name VARCHAR(100) NOT NULL COMMENT '商品名称',
    category VARCHAR(50) NOT NULL COMMENT '商品分类',
    description TEXT COMMENT '商品描述',
    price DECIMAL(10, 2) NOT NULL COMMENT '商品价格',
    cost_price DECIMAL(10, 2) COMMENT '成本价格',
    stock INT DEFAULT 0 COMMENT '库存数量',
    min_stock INT DEFAULT 10 COMMENT '最小库存',
    unit VARCHAR(20) COMMENT '单位',
    supplier_id INT COMMENT '供应商ID',
    status ENUM('available', 'discontinued', 'out_of_stock') DEFAULT 'available' COMMENT '状态',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    remark VARCHAR(255) COMMENT '备注',
    INDEX idx_product_code (product_code),
    INDEX idx_category (category),
    INDEX idx_supplier_id (supplier_id),
    INDEX idx_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='商品表';

-- 3. 供应商表
CREATE TABLE IF NOT EXISTS suppliers (
    id INT AUTO_INCREMENT PRIMARY KEY COMMENT '供应商ID',
    supplier_code VARCHAR(50) NOT NULL UNIQUE COMMENT '供应商编码',
    supplier_name VARCHAR(100) NOT NULL COMMENT '供应商名称',
    contact_person VARCHAR(50) COMMENT '联系人',
    contact_phone VARCHAR(20) COMMENT '联系电话',
    contact_email VARCHAR(100) COMMENT '联系邮箱',
    address VARCHAR(255) COMMENT '地址',
    city VARCHAR(50) COMMENT '城市',
    province VARCHAR(50) COMMENT '省份',
    zip_code VARCHAR(20) COMMENT '邮编',
    status ENUM('active', 'inactive', 'blocked') DEFAULT 'active' COMMENT '供应商状态',
    credit_rating INT DEFAULT 100 COMMENT '信用评分（0-100）',
    cooperation_since DATE COMMENT '合作开始日期',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    remark VARCHAR(255) COMMENT '备注',
    INDEX idx_supplier_code (supplier_code),
    INDEX idx_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='供应商表';

-- 4. 采购订单表
CREATE TABLE IF NOT EXISTS purchase_orders (
    id INT AUTO_INCREMENT PRIMARY KEY COMMENT '采购订单ID',
    po_number VARCHAR(50) NOT NULL UNIQUE COMMENT '采购订单号',
    supplier_id INT NOT NULL COMMENT '供应商ID',
    order_date DATE NOT NULL COMMENT '订单日期',
    required_date DATE COMMENT '要求交货日期',
    delivery_date DATE COMMENT '实际交货日期',
    total_amount DECIMAL(12, 2) NOT NULL COMMENT '订单总金额',
    status ENUM('draft', 'confirmed', 'shipped', 'received', 'cancelled') DEFAULT 'draft' COMMENT '订单状态',
    created_by INT COMMENT '创建人ID',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    remark VARCHAR(255) COMMENT '备注',
    FOREIGN KEY (supplier_id) REFERENCES suppliers(id),
    FOREIGN KEY (created_by) REFERENCES users(id),
    INDEX idx_po_number (po_number),
    INDEX idx_supplier_id (supplier_id),
    INDEX idx_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='采购订单表';

-- 5. 采购订单明细表
CREATE TABLE IF NOT EXISTS purchase_order_items (
    id INT AUTO_INCREMENT PRIMARY KEY COMMENT '采购订单明细ID',
    po_id INT NOT NULL COMMENT '采购订单ID',
    product_id INT NOT NULL COMMENT '商品ID',
    quantity INT NOT NULL COMMENT '数量',
    unit_price DECIMAL(10, 2) NOT NULL COMMENT '单价',
    line_total DECIMAL(12, 2) NOT NULL COMMENT '行总金额',
    received_quantity INT DEFAULT 0 COMMENT '已收货数量',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    FOREIGN KEY (po_id) REFERENCES purchase_orders(id),
    FOREIGN KEY (product_id) REFERENCES products(id),
    INDEX idx_po_id (po_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='采购订单明细表';

-- 6. 订单表
CREATE TABLE IF NOT EXISTS orders (
    id INT AUTO_INCREMENT PRIMARY KEY COMMENT '订单ID',
    order_number VARCHAR(50) NOT NULL UNIQUE COMMENT '订单号',
    customer_id INT COMMENT '客户ID',
    customer_name VARCHAR(100) COMMENT '客户名称',
    order_date DATE NOT NULL COMMENT '订单日期',
    delivery_date DATE COMMENT '交货日期',
    total_amount DECIMAL(12, 2) NOT NULL COMMENT '订单总金额',
    status ENUM('pending', 'confirmed', 'shipped', 'delivered', 'cancelled') DEFAULT 'pending' COMMENT '订单状态',
    payment_status ENUM('unpaid', 'partial', 'paid') DEFAULT 'unpaid' COMMENT '支付状态',
    created_by INT COMMENT '创建人ID',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    remark VARCHAR(255) COMMENT '备注',
    FOREIGN KEY (created_by) REFERENCES users(id),
    INDEX idx_order_number (order_number),
    INDEX idx_status (status),
    INDEX idx_order_date (order_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='订单表';

-- 7. 订单明细表
CREATE TABLE IF NOT EXISTS order_items (
    id INT AUTO_INCREMENT PRIMARY KEY COMMENT '订单明细ID',
    order_id INT NOT NULL COMMENT '订单ID',
    product_id INT NOT NULL COMMENT '商品ID',
    quantity INT NOT NULL COMMENT '数量',
    unit_price DECIMAL(10, 2) NOT NULL COMMENT '单价',
    line_total DECIMAL(12, 2) NOT NULL COMMENT '行总金额',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (product_id) REFERENCES products(id),
    INDEX idx_order_id (order_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='订单明细表';

-- 8. 新闻表
CREATE TABLE IF NOT EXISTS news (
    id INT AUTO_INCREMENT PRIMARY KEY COMMENT '新闻ID',
    title VARCHAR(200) NOT NULL COMMENT '新闻标题',
    content LONGTEXT NOT NULL COMMENT '新闻内容',
    author_id INT COMMENT '作者ID',
    category VARCHAR(50) COMMENT '新闻分类',
    status ENUM('draft', 'published', 'archived') DEFAULT 'draft' COMMENT '新闻状态',
    view_count INT DEFAULT 0 COMMENT '浏览次数',
    publish_date DATETIME COMMENT '发布时间',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    remark VARCHAR(255) COMMENT '备注',
    FOREIGN KEY (author_id) REFERENCES users(id),
    INDEX idx_status (status),
    INDEX idx_category (category),
    INDEX idx_publish_date (publish_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='新闻表';

-- 9. 系统日志表
CREATE TABLE IF NOT EXISTS system_logs (
    id INT AUTO_INCREMENT PRIMARY KEY COMMENT '日志ID',
    user_id INT COMMENT '用户ID',
    action VARCHAR(100) NOT NULL COMMENT '操作类型',
    module VARCHAR(50) COMMENT '模块名称',
    description TEXT COMMENT '操作描述',
    ip_address VARCHAR(50) COMMENT 'IP地址',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '操作时间',
    FOREIGN KEY (user_id) REFERENCES users(id),
    INDEX idx_user_id (user_id),
    INDEX idx_module (module),
    INDEX idx_created_at (created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='系统日志表';

-- 插入测试数据

-- 插入管理员用户
INSERT INTO users (username, password, email, phone, real_name, gender, role, department, status) VALUES
('admin', '$2a$10$SlYQmyNdGzin7olVN3/p2OPST9/PgBkqquzi.Ss7KIUgO2t0jKMm2', 'admin@yuanyang.com', '13800000001', '管理员', 'M', 'admin', 'IT部', 'active'),
('manager', '$2a$10$SlYQmyNdGzin7olVN3/p2OPST9/PgBkqquzi.Ss7KIUgO2t0jKMm2', 'manager@yuanyang.com', '13800000002', '经理', 'F', 'manager', '采购部', 'active'),
('user1', '$2a$10$SlYQmyNdGzin7olVN3/p2OPST9/PgBkqquzi.Ss7KIUgO2t0jKMm2', 'user1@yuanyang.com', '13800000003', '员工1', 'M', 'user', '销售部', 'active');

-- 插入供应商数据
INSERT INTO suppliers (supplier_code, supplier_name, contact_person, contact_phone, contact_email, address, city, province, status, credit_rating) VALUES
('SUP001', '浙江制造有限公司', '张三', '13900000001', 'zhangsan@supplier.com', '杭州市余杭区', '杭州', '浙江', 'active', 95),
('SUP002', '上海工业集团', '李四', '13900000002', 'lisi@supplier.com', '上海市浦东新区', '上海', '上海', 'active', 90),
('SUP003', '广州贸易公司', '王五', '13900000003', 'wangwu@supplier.com', '广州市天河区', '广州', '广东', 'active', 85);

-- 插入商品数据
INSERT INTO products (product_code, product_name, category, description, price, cost_price, stock, min_stock, unit, supplier_id, status) VALUES
('PROD001', '家居用品-台灯', '家居用品', '现代简约风格台灯', 159.99, 80.00, 150, 20, '件', 1, 'available'),
('PROD002', '家居用品-靠枕', '家居用品', '舒适护颈靠枕', 89.99, 40.00, 300, 50, '件', 1, 'available'),
('PROD003', '家电-咖啡机', '家电', '全自动咖啡机', 599.99, 300.00, 50, 10, '台', 2, 'available'),
('PROD004', '服装-T恤', '服装', '纯棉T恤', 79.99, 30.00, 500, 100, '件', 3, 'available'),
('PROD005', '服装-牛仔裤', '服装', '经典蓝色牛仔裤', 199.99, 80.00, 200, 50, '件', 3, 'available');

-- 插入新闻数据
INSERT INTO news (title, content, author_id, category, status, publish_date) VALUES
('新品上市', '远洋百货推出新款家居用品系列', 1, '产品', 'published', NOW()),
('供应链优化', '我们已实现供应链效率提升30%', 1, '新闻', 'published', NOW()),
('春季促销', '全场商品享受折扣优惠，欢迎选购', 2, '活动', 'published', NOW());

-- 创建索引优化查询性能
CREATE INDEX idx_po_supplier_date ON purchase_orders(supplier_id, order_date);
CREATE INDEX idx_order_status_date ON orders(status, order_date);
CREATE INDEX idx_product_stock ON products(stock, min_stock);

-- 设置字符集
ALTER DATABASE yuanyang CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

COMMIT;