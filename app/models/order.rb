class Order < ApplicationRecord
  belongs_to :user
  has_many :ordermembers
  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
  def user_name
  user.try(:name)
end

def user_name=(name)
  self.user = User.find_by(name: name) if name.present?
end
end
