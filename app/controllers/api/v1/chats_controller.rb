
module Api
    module V1
      class ChatsController < ApiController
  
        def create
            chat  = Chat.new(message: chat_params[:message])
            chat.sender = fetch_user(chat_params[:sender_type], chat_params[:sender_id])
            chat.receiver = fetch_user(chat_params[:receiver_type], chat_params[:receiver_id])
            if chat.save
                render json: {message: 'message sent'}, status: :ok
            else
                render json: {message: 'message failed'}, status: :bad_request
            end
        end
  
        private
  
        def chat_params
          params.require(:chat).permit(:sender_id, :receiver_id, :receiver_type, :message, :sender_type)
        end

        def fetch_user(type, id)
            return AdminUser.find(id) if type == 'admin'
            
            User.find(id)
        end
      end
    end
  end
  