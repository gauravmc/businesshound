class Store < ActiveRecord::Base
  validates :name, presence: { message: "Store name is required" }
  validates :name, uniqueness: { scope: :company_id, case_sensitive: false, message: "%{value} already exists" }
  validates_presence_of :factories, message: "Select at least one factory that supplies to this store", if: ->(store) { store.company.factories.any? }
  
  belongs_to :company
  belongs_to :manager, class_name: 'User', dependent: :destroy
  has_many :products, through: :company
  has_many :supplies, dependent: :destroy
  has_many :stocks, dependent: :destroy
  has_and_belongs_to_many :factories

  accepts_nested_attributes_for :stocks

  def gets_supplies_by?(factory)
  	factories.include? factory
  end

  def has_entered_stock_on?(date)
    stocks.where(left_on: date).any?
  end

  def find_stock_by_attributes(left_on, product_id)
    stock = stocks.where(product_id: product_id, left_on: left_on).pop
    stock.present? ? stock : false
  end

  def fetch_stocks(left_on)
    stocks = []
    products.each do |product|
      stocks << if stock = find_stock_by_attributes(left_on, product.id)
        stock
      else
        self.stocks.create(product_id: product.id, quantity: 0, left_on: left_on)
      end
    end
    stocks
  end

  def goods_supplied_on?(date)
    supplies.where(supplied_on: date).any?
  end

  def stocks_entered_on?(date)
    stocks.where(left_on: date).any?
  end
end
