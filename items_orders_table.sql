CREATE TABLE items_orders (
  item_id int,
  order_id int,
  constraint fk_item foreign key(item_id) references items(id) on delete cascade,
  constraint fk_order foreign key(order_id) references orders(id) on delete cascade,
  PRIMARY KEY (item_id, order_id)
);


-- This snippet is taken from the Two Tables Schema Design Recipe document
-- constraint fk_artist foreign key(artist_id)
--     references artists(id) 
--     on delete cascade 