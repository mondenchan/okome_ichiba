class Order < ApplicationRecord
  belongs_to :item
  has_one :delivery
end
