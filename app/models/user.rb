class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  attr_accessible :name, :email, :password, :password_confirmation, :remember_me


  validates :name, presence: true
end
