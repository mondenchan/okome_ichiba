require 'rails_helper'

RSpec.describe OrderDelivery, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @order_delivery = FactoryBot.build(:order_delivery, user_id: user.id, item_id: item.id)
#    sleep(0.2)
  end

  describe '配送先情報の保存' do
    context '配送先情報の保存ができるとき' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@order_delivery).to be_valid
      end
      it 'user_idが空でなければ保存できる' do
        @order_delivery.user_id = 1
        expect(@order_delivery).to be_valid
      end
      it 'item_idが空でなければ保存できる' do
        @order_delivery.item_id = 1
        expect(@order_delivery).to be_valid
      end
      it '郵便番号が「3桁＋ハイフン＋4桁」の組み合わせであれば保存できる' do
        @order_delivery.postal_code = '123-4560'
        expect(@order_delivery).to be_valid
      end
      it '都道府県が「---」以外かつ空でなければ保存できる' do
        @order_delivery.prefecture_id = 1
        expect(@order_delivery).to be_valid
      end
      it '市区町村が空でなければ保存できる' do
        @order_delivery.city = '大和郡山市'
        expect(@order_delivery).to be_valid
      end
      it '番地が空でなければ保存できる' do
        @order_delivery.house_number = '野地１２３'
        expect(@order_delivery).to be_valid
      end
      it '建物名が空でも保存できる' do
        @order_delivery.build_number = nil
        expect(@order_delivery).to be_valid
      end
      it '電話番号が11番桁以内かつハイフンなしであれば保存できる' do
        @order_delivery.phone_number = 12_345_678_910
        expect(@order_delivery).to be_valid
      end
    end

    context '配送先情報の保存ができないとき' do
      it 'user_idが空だと保存できない' do
        @order_delivery.user_id = nil
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("User can't be blank")
      end
      it 'item_idが空だと保存できない' do
        @order_delivery.item_id = nil
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Item can't be blank")
      end
      it '郵便番号が空だと保存できないこと' do
        @order_delivery.postal_code = nil
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Postal code can't be blank")
      end
      it '郵便番号にハイフンがないと保存できないこと' do
        @order_delivery.postal_code = 1_234_567
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
      end
      it '都道府県が「---」だと保存できないこと' do
        @order_delivery.prefecture_id = 0
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Prefecture can't be blank")
      end
      it '都道府県が空だと保存できないこと' do
        @order_delivery.prefecture_id = nil
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Prefecture can't be blank")
      end
      it '市区町村が空だと保存できないこと' do
        @order_delivery.city = nil
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("City can't be blank")
      end
      it '番地が空だと保存できないこと' do
        @order_delivery.house_number = nil
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("House number can't be blank")
      end
      it '電話番号が空だと保存できないこと' do
        @order_delivery.phone_number = nil
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Phone number can't be blank")
      end
      it '電話番号にハイフンがあると保存できないこと' do
        @order_delivery.phone_number = '123 - 1234 - 1234'
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include('Phone number is invalid')
      end
      it '電話番号が12桁以上あると保存できないこと' do
        @order_delivery.phone_number = "090123456789"
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include('Phone number is invalid')
      end
      it '電話番号が9桁であると保存できないこと' do
        @order_delivery.phone_number = "090123456"
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include('Phone number is invalid')
      end
      it 'トークンが空だと保存できないこと' do
        @order_delivery.token = nil
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end