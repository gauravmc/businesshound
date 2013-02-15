class CashEntry < ActiveRecord::Base
  serialize :denomination, Hash

  CURRENCIES = %w{thousand five_hundred hundred fifty twenty ten five two one}.map &:to_sym
  CURRENCIES.map do |currency|
  	attr_accessor currency
  	validates_numericality_of currency
  end
  validates :store, :made_on, presence: true
  validates :store_id, uniqueness: { scope: :made_on, message: "Entry already made for given date." }
  belongs_to :store

  before_validation :format_currency_denomination
  before_save :create_denomination_from_individual_entries

  private

  def format_currency_denomination
  	CURRENCIES.each do |currency|
  		if send(currency).blank?
  			eval "self.#{currency.to_s} = 0"
  		end
  	end
  end

  def create_denomination_from_individual_entries
  	self.denomination = {}
  	CURRENCIES.each do |currency|
  		self.denomination[currency] = send(currency)
  	end
  end
end
