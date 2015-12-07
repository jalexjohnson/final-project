class Product < ActiveRecord::Base

  # http://stackoverflow.com/questions/1187138/ruby-on-rails-can-i-modify-data-before-it-is-saved
  before_save { |product| product.sku = product.sku.downcase }

  belongs_to :user
  validates :sku, presence: true
  validates_uniqueness_of :sku, scope: :user_id

  def can_change?(user)
    return user.present? && user == self.user
  end

  #http://stackoverflow.com/questions/6345383/how-to-create-complex-json-response-in-ruby-in-rails
  def as_json(options={})
    super(except: [:id, :user_id])
  end

end
