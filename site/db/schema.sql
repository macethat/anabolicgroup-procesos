-- Esquema base del catalogo (MySQL/MariaDB, utf8mb4)
-- Anabolic Group - test.anabolicgroup.com

CREATE TABLE IF NOT EXISTS brands (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL UNIQUE,
  slug VARCHAR(120) NOT NULL UNIQUE,
  sort_order INT DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS categories (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  slug VARCHAR(120) NOT NULL UNIQUE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS products (
  id INT AUTO_INCREMENT PRIMARY KEY,
  brand_id INT NOT NULL,
  category_id INT NULL,
  name VARCHAR(200) NOT NULL,
  slug VARCHAR(220) NOT NULL UNIQUE,
  excerpt VARCHAR(500) NULL,
  description MEDIUMTEXT NULL,
  presentation VARCHAR(120) NULL,
  price DECIMAL(10,2) NULL,
  currency CHAR(3) DEFAULT 'USD',
  stock_status ENUM('instock','outofstock') DEFAULT 'instock',
  is_published TINYINT(1) DEFAULT 1,
  image VARCHAR(255) NULL,
  seo_title VARCHAR(200) NULL,
  seo_description VARCHAR(320) NULL,
  sort_order INT DEFAULT 0,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY idx_brand (brand_id),
  KEY idx_category (category_id),
  CONSTRAINT fk_products_brand FOREIGN KEY (brand_id) REFERENCES brands(id),
  CONSTRAINT fk_products_category FOREIGN KEY (category_id) REFERENCES categories(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS presentations (
  id INT AUTO_INCREMENT PRIMARY KEY,
  product_id INT NOT NULL,
  label VARCHAR(60) NOT NULL,
  price DECIMAL(10,2) NULL,
  stock_status ENUM('instock','outofstock') DEFAULT 'instock',
  sort_order INT DEFAULT 0,
  KEY idx_product (product_id),
  CONSTRAINT fk_presentations_product FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS settings (
  `key` VARCHAR(64) PRIMARY KEY,
  `value` TEXT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO settings (`key`, `value`) VALUES
  ('site_name', 'Anabolic Group'),
  ('currency', 'USD'),
  ('whatsapp_number', ''),
  ('whatsapp_message', 'Hola, me interesa este producto: ')
ON DUPLICATE KEY UPDATE `value` = `value`;
