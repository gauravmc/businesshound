require 'test_helper'

class Store::StocksControllerTest < ActionController::TestCase
	setup	do
		@valid_stocks = { stocks_attributes: {
			  "0" => { quantity: 50, product_id: products(:iphone).id },
			  "1" => { quantity: 100, product_id: products(:ipad).id },
			  "2" => { quantity: 150, product_id: products(:ipod).id }
			},
			left_on: '2012-12-12'
		}

		@invalid_stocks = { stocks_attributes: {
			  "0" => { quantity: 'abc', product_id: products(:iphone).id },
			  "1" => { quantity: 20, product_id: products(:ipad).id },
			  "2" => { quantity: 30, product_id: products(:ipod).id }
			},
			left_on: '2012-12-12'
		}
   end

	test "creates new left over stock when valid attributes supplied" do
		assert_difference('Stock.count', 3) do
   		post :create, store: @valid_stocks
   	end

   	assert flash[:success]
  end

  test "does not create left over stock records with invalid attributes" do
		assert_no_difference('Stock.count', 3) do
   		post :create, store: @invalid_stocks
   	end

   	assert !flash[:success]
  end

  test "updates stock quantity when supplied with valid attributes" do
  	store = stores(:apple_store)
  	store.fetch_stocks Date.today
		put :update, id: store.id, store: @valid_stocks.merge!(left_on: Date.today)

		assert flash[:success]
    assert_equal 100, store.stocks.where(product_id: products(:ipad).id).pop.quantity
  end

  def setup
  	super
  	log_in users(:apple_store_manager)
  end
end
