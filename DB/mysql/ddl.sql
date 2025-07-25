-- init/ddl.sql
USE mydb;

CREATE TABLE users (
  user_id BIGINT AUTO_INCREMENT PRIMARY KEY,
  email VARCHAR(100),
  password VARCHAR(100),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE market (
  market_id BIGINT AUTO_INCREMENT PRIMARY KEY,
  market_name VARCHAR(100)
);

CREATE TABLE products (
  product_id BIGINT AUTO_INCREMENT PRIMARY KEY,
  market_id BIGINT NOT NULL,
  product_name VARCHAR(100) NOT NULL,
  product_price INT NOT NULL,
  FOREIGN KEY (market_id) REFERENCES market(market_id)
);

CREATE TABLE orders (
  order_id BIGINT AUTO_INCREMENT PRIMARY KEY,
  user_id BIGINT NOT NULL,
  product_id BIGINT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(user_id),
  FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE reviews (
  review_id BIGINT AUTO_INCREMENT PRIMARY KEY,
  user_id BIGINT NOT NULL,
  order_id BIGINT NOT NULL,
  product_id BIGINT NOT NULL,
  rating INT NOT NULL,
  review VARCHAR(500) NOT NULL DEFAULT '',
  status ENUM('pending', 'approved') NOT NULL DEFAULT 'pending',
  updated_at TIMESTAMP NULL DEFAULT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(user_id),
  FOREIGN KEY (order_id) REFERENCES orders(order_id),
  FOREIGN KEY (product_id) REFERENCES products(product_id)
);
