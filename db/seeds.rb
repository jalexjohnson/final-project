Product.destroy_all
User.destroy_all

user = User.create uid: 26268389
user.key = '27dfa3601c241dd24a0f4e16b8c203b4'
user.save

Product.create sku: 'B0002F58TG', on_hand: 20, user_id: user.id
Product.create sku: 'B0009EU0S4', on_hand: 20, user_id: user.id
Product.create sku: 'B00466HM28', on_hand: 20, user_id: user.id
Product.create sku: 'B000FMDIXY', on_hand: 20, user_id: user.id
Product.create sku: 'B00HVLUR86', on_hand: 20, user_id: user.id
Product.create sku: 'B0002CZUV0', on_hand: 20, user_id: user.id
Product.create sku: 'B00COC61LO', on_hand: 20, user_id: user.id
Product.create sku: 'B00DWJ1WYY', on_hand: 20, user_id: user.id
