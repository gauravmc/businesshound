class Product < ActiveRecord::Base
  validates :name, :price, presence: true
  validates :price, numericality: { greater_than: 0, message: "should be more than 0"}
  validates :name, uniqueness: { scope: :company_id, case_sensitive: false, message: "%{value} already exists" }

  belongs_to :company
  has_many :supplies, dependent: :destroy
  has_many :stocks, dependent: :destroy
end
