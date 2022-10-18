# item repository class

require_relative './item'

class ItemRepository

    def all

        export = []
        query = DatabaseConnection.exec_params("SELECT * FROM items;",[])
        query.each do |item|
            it = Item.new
            it.id = item["id"]
            it.name = item["name"]
            it.unitprice = item["unitprice"]
            it.quantity = item["quantity"]
            export.append(it)
        end
        return export

    end

    def create(item)

        DatabaseConnection.exec_params(
            "INSERT INTO items (name,unitprice,quantity) VALUES ($1,$2,$3)",
            [
                item.name,
                item.unitprice,
                item.quantity
            ]
        )
        return item

    end

    def delete(id)

        DatabaseConnection.exec_params(
            "DELETE FROM items WHERE id=$1",
            [id]
        )

    end

    def find(value,column)

        fail "Invalid column!" if (column!="name" && column!="id")

        item = DatabaseConnection.exec_params(
            "SELECT * FROM items WHERE #{column}=$1;",
            [value]
        )[0]
        
        itM = Item.new
        itM.id = item["id"]
        itM.name = item["name"]
        itM.unitprice = item["unitprice"]
        itM.quantity = item["quantity"]
        
        return itM

    end

end