class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :items
  has_many :orders

  with_options presence: true do 
  validates :nickname, presence: true
  validates :family_name, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/ }
  validates :first_name, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/ }
  validates :family_name_kana, format: { with: /\A[ァ-ヶー－]+\z/ }
  validates :first_name_kana, format: { with: /\A[ァ-ヶー－]+\z/ }
  validates :birthday
  end
  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGEX, message: 'Include both letters and numbers'
  
end