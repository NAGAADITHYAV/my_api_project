ActiveAdmin.register Chat do
  config.batch_actions = false

  collection_action :load_messages, method: :get do
    @user = User.find_by(id: params[:user_id])
    @messages = Chat.where(sender_id: current_admin_user.id, receiver: @user)
                                     .or(Chat.where(sender: @user, receiver_id: current_admin_user.id))
    render 'admin/chats/chat'
  end

  collection_action :load_chat_listing, method: :get do
    @users = User.joins("INNER JOIN chats ON (chats.receiver_type = 'User' AND chats.receiver_id = users.id) OR
                  (chats.sender_type = 'User' AND chats.sender_id = users.id)")
                 .joins("INNER JOIN admin_users ON (chats.receiver_type = 'AdminUser' AND chats.receiver_id =
                  admin_users.id) OR (chats.sender_type = 'AdminUser' AND chats.sender_id = admin_users.id)")
                 .where('admin_users.id = ?', current_admin_user.id).distinct
    render 'admin/chats/user_listing'
  end

  collection_action :reply_message, method: :post do
    chat = Chat.create(message: reply_params[:message], sender: current_admin_user, receiver: fetch_user(reply_params[:receiver_type], reply_params[:receiver_id]))
    redirect_to action: :load_messages, user_id: reply_params[:receiver_id]
  end

  controller do
    private

    def reply_params
      params[:reply_message]
    end

    def fetch_user(type, id)
      return AdminUser.find(id) if type == 'admin'

      User.find(id)
    end
  end
end
