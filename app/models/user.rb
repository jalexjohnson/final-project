class User < ActiveRecord::Base
  before_create :generate_key

  has_many :products, dependent: :destroy
  validates :uid, presence: true

  #http://railscasts.com/episodes/352-securing-an-api?view=asciicast
  def generate_key
    begin
      self.key = SecureRandom.hex
    end while self.class.exists?(key: key)
  end
end
