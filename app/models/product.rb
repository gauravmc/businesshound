class Product < ActiveRecord::Base
	default_scope order(:position)
	scope :produced, where(kind: 'produced')
	scope :traded, where(kind: 'traded')

  validates :name, presence: true, uniqueness: { scope: :company_id, case_sensitive: false, message: "%{value} already exists" }
  validates :price, presence: true, numericality: { greater_than: 0, message: "should be more than 0"}
  validates :kind, inclusion: { in: %w{produced traded}, message: "%{value} is not a valid kind"}

  belongs_to :company
  has_many :supplies, dependent: :destroy
  has_many :stocks, dependent: :destroy
  acts_as_list scope: :company
end
