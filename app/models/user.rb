class User < ActiveRecord::Base
  has_many :products, dependent: :destroy
  validates :uid, presence: true
end
