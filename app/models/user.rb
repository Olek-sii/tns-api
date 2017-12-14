class User < ActiveRecord::Base
  # Include default devise modules.
  devise :validatable, :omniauthable, :database_authenticatable
         # :registerable,
         # :recoverable,
         # :rememberable,
         # :trackable,
         # :confirmable,
  include DeviseTokenAuth::Concerns::User

  has_many :messages
end
