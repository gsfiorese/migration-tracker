class User < ApplicationRecord
  # 1 user has many logs : dependent: :nullify means that if a user is deleted, the logs will not be deleted.
  has_many :logs, dependent: :nullify
  has_many :comments

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  # Method to create a new user from the google oauth2 response
  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data['email']).first

    unless user
      user = User.create(
        email: data['email'],
        password: Devise.friendly_token[0, 20],
        first_name: data['first_name'],
        last_name: data['last_name']
      )
    end
    user
  end

  # Role helpers to redirect users after sign in/login in.
  def admin?
    role == 'admin'
  end

  def member?
    role == 'member'
  end
end
