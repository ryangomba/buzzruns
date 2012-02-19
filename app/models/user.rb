class User < ActiveRecord::Base
  
  belongs_to :athlete
  attr_accessible :login, :password, :password_confirmation, :admin, :athlete_id
  has_secure_password
  validates_presence_of :login, :password, :on => :create
  
  devise :database_authenticatable, :oauthable, :registerable,
           :recoverable, :rememberable, :trackable, :validatable,
           :confirmable, :lockable
  has_many :services, :dependent => :destroy
  
end
