module Store::StocksHelper
	def old_stock(product, store, date)
		product.stocks.where(store_id: store.id, left_on: (format_date(date) - 1.day)).first.quantity
	end

	def todays_supplies(product, store, date)
		product.supplies.where(store_id: store.id, supplied_on: format_date(date)).first.quantity
	end

	def left_over_stock(product, store, date)
		product.stocks.where(store_id: store.id, left_on: format_date(date)).first.quantity
	end

	def format_date(date)
		if date.class != Date
			DateTime.strptime(date, '%Y-%m-%d').to_date
		else
			date
		end
	end
end
