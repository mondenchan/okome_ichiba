class Category < ActiveHash::Base
  self.data = [
    { id: 0, name: '--' },
    { id: 1, name: 'うるち米（玄米）' },
    { id: 2, name: 'うるち米（白米）' },
    { id: 3, name: '餅米（玄米）' },
    { id: 4, name: '餅米（白米）' },
    { id: 5, name: '酒米（山田錦）' },
    { id: 6, name: '野菜（根菜）' },
    { id: 7, name: '野菜（葉菜）' },
    { id: 8, name: '野菜（果菜）' },
    { id: 9, name: '食品' },
    { id: 10, name: 'その他' }
  ]

  include ActiveHash::Associations
  has_many :items
end