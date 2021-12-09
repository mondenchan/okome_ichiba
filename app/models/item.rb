class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  
  belongs_to :user
  has_one :order
  has_one_attached :image

  belongs_to_active_hash :category
  belongs_to_active_hash :status
  belongs_to_active_hash :postage
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :shipping_day

  with_options presence: true do
    validates :user
    validates :image
    validates :name, length: { maximum: 40 }
    validates :explanation, length: { maximum: 1000 }
    validates :price, numericality: { only_integer: true, greater_than: 299, less_than: 10000000 }
    validates :category_id, numericality: { other_than: 0 }
    validates :status_id, numericality: { other_than: 0 }
    validates :postage_id, numericality: { other_than: 0 }
    validates :prefecture_id, numericality: { other_than: 0 }
    validates :shipping_day_id, numericality: { other_than: 0 }
  end

end
