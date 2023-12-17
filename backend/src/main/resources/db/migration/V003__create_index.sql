CREATE INDEX idx_orders_id ON orders (id);
CREATE INDEX idx_orders_status_date ON orders (status, date_created);

CREATE INDEX idx_product_id ON product (id);

CREATE INDEX ix_order_product_order_id_product_id ON order_product(order_id, product_id);