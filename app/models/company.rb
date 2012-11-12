class Company < ActiveRecord::Base
  cattr_accessor :creating_new
  @@creating_new = false
    
  validates :name, :currency, presence: { message: "is required" }
  
  has_many :users, dependent: :destroy
  has_many :products, dependent: :destroy
  has_many :stores, dependent: :destroy
end
