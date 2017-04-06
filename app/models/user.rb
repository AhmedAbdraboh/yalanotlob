class User < ApplicationRecord


has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
<<<<<<< HEAD
 devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
     :omniauthable, :omniauth_providers => [:facebook]

  def self.from_omniauth(auth)
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.provider = auth.provider
        user.uid = auth.uid
        user.email = auth.info.email
user.name = auth.info.name
        user.password = Devise.friendly_token[0,20]
   end
end

  has_friendship

=======
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
  has_many :orders
  has_many :notifications
>>>>>>> 871e23d5669e2a6ebdf2cf31dc2d1d2919cf0ccc
end
