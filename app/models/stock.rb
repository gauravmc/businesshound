class Stock < ActiveRecord::Base
  attr_accessible :left_on, :quantity, :store_id
  validates_presence_of :quantity

  belongs_to :product
  belongs_to :store
end
