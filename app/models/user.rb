class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: { user: "user", admin: "admin" }


  after_initialize :set_default_role, if: :new_record? # Set default role on creation

  private

  def set_default_role
    self.role ||= "user"
  end
end
