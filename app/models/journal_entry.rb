class JournalEntry < ActiveRecord::Base
  attr_accessible :amount, :message, :store_id, :kind, :occured_on
  validates :kind, inclusion: { in: %w(debit credit), message: "%{value} is not a valid type of transaction" }
  validates_presence_of :message, :amount, :store_id, :occured_on

  belongs_to :store
end
