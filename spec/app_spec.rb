require_relative '../app'
require_relative '../lib/order_repository'
require_relative '../lib/item_repository'
require_relative 'reseed_shop_manager_db'

RSpec.describe Application do
    describe Application do

        before(:each) do
            reseed_tables
        end


        def opens_welcome_message(io)

            expect(io).to receive(:puts).with ("Welcome to the shop management program!")
            expect(io).to receive(:puts).with (no_arguments)
            expect(io).to receive(:puts).with ("What do you want to do?")
            expect(io).to receive(:puts).with ("1 = list all shop items")
            expect(io).to receive(:puts).with ("2 = create a new item")
            expect(io).to receive(:puts).with ("3 = list all orders")
            expect(io).to receive(:puts).with ("4 = create a new order")
            expect(io).to receive(:puts).with (no_arguments)
            expect(io).to receive(:puts).with ("Enter:")

            end

            def list_of_all_shop_items(io)

            expect(io).to receive(:puts).with ("Super Shark Vacuum Cleaner', '99', '30', '002")
            expect(io).to receive(:puts).with ("Makerspresso Coffee Machine', '69', '15', '002")
            expect(io).to receive(:puts).with ("Amazon Echo Device', '100', '33','001")
            expect(io).to receive(:puts).with ("Apple TV', '150', '20', '003")
            expect(io).to receive(:puts).with ("Samsung TV', '1000', '10', '004")
            expect(io).to receive(:puts).with ("HP Laptop', '400', '17', '005")
            expect(io).to receive(:puts).with ("SKY Broadband', '100', '13', '7")

            end

            def list_all_orders(io)


                    expect(io).to receive(:puts).with ("Peter', '01/01/2023', '001")
                    expect(io).to receive(:puts).with ("John', '02/01/2023', '002")
                    expect(io).to receive(:puts).with ("Jane', '03/01/2023', '003")
                    expect(io).to receive(:puts).with ("Jessica', '04/01/2023', '004")
                    expect(io).to receive(:puts).with ("Kate', '05/01/2023', '005")
                    expect(io).to receive(:puts).with ("Luisa', '06/01/2023', '006")
            end


            it "shows all items" do
                io = double :io
                shows_all_items(io)
                item_repository = ItemRepository.new
                order_repository = OrderRepository.new

                app.Application.new ('shop_manager_test', io, item_repository, order_repository)
                app.shows_all_items
            end


            it "shows all orders" do
                io = double :io
                shows_all_orders(io)
                item_repository = ItemRepository.new
                order_repository = OrderRepository.new

                app.Application.new ('shop_manager_test', io, item_repository, order_repository)
                app.shows_all_orders
            end


            it "shows all items when a user selects 1" do
                io = double :io
                opens_welcome_message(io)
                expect(io).to receive(:gets).and_return("1")
                shows_all_items(io)
                expect(io).to receive(:puts).with(no_arguments)
                item_repository = ItemRepository.new
                order_repository = OrderRepository.new

                app.Application.new ('shop_manager_test', io, item_repository, order_repository)
                app.run
            end

            it "shows all orders when a user selects 3" do

                io = double :io
                opens_welcome_message(io)
                expect(io).to receive(:gets).and_return("3")
                shows_all_orders(io)
                expect(io).to receive(:puts).with(no_arguments)
                item_repository = ItemRepository.new
                order_repository = OrderRepository.new

                app.Application.new ('shop_manager_test', io, item_repository, order_repository)
                app.run

            end

            it "throws an error message when a user selects the wrong choice" do

                io = double :io
                opens_welcome_message(io)
                expect(io).to receive(:gets).and_return("7")
                expect(io).to receive(:puts).with("You provided the wrong number")
                expect(io).to receive(:puts).with(no_arguments)
                item_repository = ItemRepository.new
                order_repository = OrderRepository.new

                app.Application.new ('shop_manager_test', io, item_repository, order_repository)
                app.run

            end

            it "creates a new item" do
                io = double :io
                opens_welcome_message(io)
                expect(io).to receive(:gets).and_return("2")
                expect(io).to receive(:gets).with("A newly item was created")
                expect(io).to receive(:puts).with("LG TV - Unit_price: 2000, Quantity: 7")
                expect(io).to receive(:puts).with(no_arguments)
                expect(io).to receive(:puts)
                item_repository = ItemRepository.new
                order_repository = OrderRepository.new

                app.Application.new ('shop_manager_test', io, item_repository, order_repository)
                app.run

            end


            it "creates a new order" do
                io = double :io
                opens_welcome_message(io)
                expect(io).to receive(:gets).and_return("4")
                expect(io).to receive(:gets).with("A newly order was created")
                expect(io).to receive(:puts).with("Customer_name: Bianca, Order_date: 07/01/2023" )
                expect(io).to receive(:puts).with(no_arguments)
                expect(io).to receive(:puts)
                item_repository = ItemRepository.new
                order_repository = OrderRepository.new

                app.Application.new ('shop_manager_test', io, item_repository, order_repository)
                app.run

            end


            it "assumes choice 2" do


                io = double :io
                opens_welcome_message(io)
                expect(io).to receive(:gets).and_return("2")
                expect(io).to receive(:gets).with("A newly item was created")
                expect(io).to receive(:puts).with("LG TV - Unit_price: 2000, Quantity: 7")
                expect(io).to receive(:puts).with(no_arguments)
                expect(io).to receive(:puts)

                item_repository = ItemRepository.new
                order_repository = OrderRepository.new

                app.Application.new ('shop_manager_test', io, item_repository, order_repository)
                app.assumes_choice("2")

            end


            it "assumes choice 4" do


                io = double :io
                opens_welcome_message(io)
                expect(io).to receive(:gets).and_return("2")
                expect(io).to receive(:gets).with("A newly item was created")
                expect(io).to receive(:puts).with("LG TV - Unit_price: 2000, Quantity: 7")
                expect(io).to receive(:puts).with(no_arguments)
                expect(io).to receive(:puts)

                item_repository = ItemRepository.new
                order_repository = OrderRepository.new

                app.Application.new ('shop_manager_test', io, item_repository, order_repository)
                app.assumes_choice("4")

            end


            it "assumes choice 1" do


                io = double :io
                opens_welcome_message(io)
                expect(io).to receive(:puts).with(no_arguments)
                shows_all_items(io)
                item_repository = ItemRepository.new
                order_repository = OrderRepository.new

                app.Application.new ('shop_manager_test', io, item_repository, order_repository)
                app.assumes_choice("1")

            end

            it "assumes choice 3" do


                io = double :io
                opens_welcome_message(io)
                expect(io).to receive(:puts).with(no_arguments)
                shows_all_orders(io)
                item_repository = ItemRepository.new
                order_repository = OrderRepository.new

                app.Application.new ('shop_manager_test', io, item_repository, order_repository)
                app.assumes_choice("3")

            end
        end
    end