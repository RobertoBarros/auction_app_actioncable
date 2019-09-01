class Product < ApplicationRecord
  belongs_to :user
  belongs_to :buyer, class_name: 'User', optional: true
  has_many :bids, dependent: :destroy

  scope :in_auction, -> { where(buyer: nil) }

end
