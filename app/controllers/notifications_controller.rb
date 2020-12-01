class NotificationsController < ApplicationController
  def update
    notification = Notification.find(params[:id])
    authorize notification

    notification.read = true
    notification.save

    redirect_to argument_path(notification.argument)
  end
end
