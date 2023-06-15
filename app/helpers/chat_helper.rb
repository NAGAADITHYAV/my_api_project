module ChatHelper
  def generate_channel_name(sender, receiver)
    "ChatChannel_#{sender.class}_#{sender.id}_to_#{receiver.class}_#{receiver.id}"
  end
end