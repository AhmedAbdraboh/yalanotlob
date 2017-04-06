class Ordermember < ApplicationRecord
  belongs_to :user
  belongs_to :order
  # after_create_commit { notify }

  # private
  #
  # def notify
  #   if self.status=="invited"
  #     Notification.create(event: "#{self.order.user.name} #{self.status} you to his order", user: self.user, order: self.order)
  #   end
  #
  # end
end
