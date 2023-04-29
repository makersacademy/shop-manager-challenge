require_relative "lib/application"

database = "shop_manager"

app = Application.new(database)

app.run