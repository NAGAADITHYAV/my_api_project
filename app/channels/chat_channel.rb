class ChatChannel < ApplicationCable::Channel
  include ChatHelper
  def subscribed
    stream_from channel_name
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  private

  def channel_name
    sender = fetch_user(params[:sender_type], params[:sender_id])
    receiver = fetch_user(params[:receiver_type], params[:receiver_id])
    generate_channel_name(sender, receiver)
  end

  def fetch_user(user_type, user_id)
    return AdminUser.find_by(id: user_id) if user_type == 'admin'

    User.find_by(id: user_id)
  end
end
