module StoresHelper
	def old_stock(product, store, date)
		stock_by_date product, store, (format_date(date) - 1.day)
	end

	def todays_supplies(product, store, date)
		supply = product.supplies.where(store_id: store.id, supplied_on: format_date(date)).first
		supply.present? ? supply.quantity : 0		
	end

	def left_over_stock(product, store, date)
		stock_by_date product, store, format_date(date)
	end

	def format_date(date)
		date.is_a?(Date) ? date : Date.strptime(date, '%Y-%m-%d')
	end

	def stock_by_date(product, store, date)
		stock = product.stocks.where(store_id: store.id, left_on: date).first
		stock.present? ? stock.quantity : 0
	end
end
