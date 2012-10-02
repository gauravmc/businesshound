class Company < ActiveRecord::Base
  cattr_accessor :creating_new
  @@creating_new = false
    
  validates :name, :currency, presence: { message: "is required" }
  validates :business_type, inclusion: { in: %w(1 2), message: "must be selected" }
  
  has_many :users, dependent: :destroy
  has_many :products, dependent: :destroy
  has_many :stores, dependent: :destroy
end
