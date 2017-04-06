class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :order
  after_create_commit { NotificationBroadcastJob.perform_later(Notification.count,self)}
end
