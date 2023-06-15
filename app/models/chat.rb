# app/models/chat.rb
class Chat < ApplicationRecord
  include ChatHelper
  belongs_to :sender, polymorphic: true
  belongs_to :receiver, polymorphic: true

  validates :message, presence: true
  #after create commit broadcast
  after_create_commit :broadcast_message

  private

  def broadcast_message
    channel = generate_channel_name(sender, receiver)
    ActionCable.server.broadcast(channel, [self, sender.email] )
  end
end