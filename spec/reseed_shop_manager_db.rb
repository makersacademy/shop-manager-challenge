def reseed_tables

        seed_orders_sql = File.read(‘spec/seeds_orders.sql’)
        seed_items_sql = File.read(‘spec/seeds_items.sql’)
        connection = PG.connect({ host: ‘127.0.0.1’, dbname: ‘shop_manager_test’ })
        connection.exec(seed_orders_sql)
        connection.exec(seed_itemss_sql)
 

end