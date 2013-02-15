require 'test_helper'

class CashEntryTest < ActiveSupport::TestCase
	setup do
		@cash_entry_attributes = {
			thousand: 20,
			five_hundred: 30,
			hundred: '',
			fifty: '',
			twenty: 40,
			ten: 120,
			five: 80,
			two: 100,
			one: 99,
			store: stores(:apple_store),
			made_on: '2013-02-15'
		}
	end

	test "create formats denomination and saves it as hash" do
		entry = CashEntry.create(@cash_entry_attributes)
		debugger
		assert_equal 0, entry.denomination[:hundred]
		assert_equal 30, entry.denomination[:five_hundred]
		assert_equal 0, entry.denomination[:fifty]
	end

	test "entry can be made only once for a given date" do
		CashEntry.create(@cash_entry_attributes)
		entry = CashEntry.create(@cash_entry_attributes)
		assert_equal ["Entry already made for given date."], entry.errors[:store_id]

		entry = CashEntry.create(@cash_entry_attributes.merge(made_on: '2012-02-15'))
		assert entry.valid?		
	end
end
