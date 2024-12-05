class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :scores

  validates :handicap, numericality: { greater_than_or_equal_to: 0 }

  def generate_reset_token!
    self.reset_token = SecureRandom.urlsafe_base64
    self.reset_sent_at = Time.current
    save!
  end

  
end

# Mailgun Api
# 99e7702a0467357b344acb4bb0499756-f55d7446-81907d06