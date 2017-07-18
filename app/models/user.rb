class User < ApplicationRecord
  has_secure_password

  validates_presence_of :first_name, :last_name, :username, :email, :phone_number, :password, :country_code
  validates_uniqueness_of :username

  enum role: %w(member manager admin)

  has_many :user_venues, as: :manager
  has_many :venues, through: :user_venues

  def manager_has_venues_with_wine?(wine)
    !(venues & wine.venues).empty?
  end
end
