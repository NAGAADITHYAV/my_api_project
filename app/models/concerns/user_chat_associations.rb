module UserChatAssociations
  extend ActiveSupport::Concern

  included do
    has_many :sent_chats, as: :sender, class_name: 'Chat', dependent: :destroy
    has_many :received_chats, as: :receiver, class_name: 'Chat', dependent: :destroy
  end
end