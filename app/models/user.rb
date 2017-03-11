class User < ApplicationRecord

  has_many :todos, dependent: :destroy
  # Assign an API key on create
  before_create do |user|
    user.api_key = user.generate_api_key
  end

  before_save :downcase_email

  #validation
  validates_presence_of :email
  validates_uniqueness_of :email, case_sensitive: false
  validates_format_of :email, with: /@/

  # downcase the email before save
  def downcase_email
    self.email = self.email.delete(' ').downcase
  end

  # Generate a unique API key
  def generate_api_key
    loop do
      token = SecureRandom.base64.tr('+/=', 'Qrt')
      break token unless User.exists?(api_key: token)
    end
  end
end
