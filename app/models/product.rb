class Product < ActiveRecord::Base

  belongs_to :user
  validates :sku, presence: true

  def can_change?(user)
    return user.present? && user == self.user
  end

end
