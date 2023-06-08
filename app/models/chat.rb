# app/models/chat.rb
class Chat < ApplicationRecord
  belongs_to :sender, polymorphic: true
  belongs_to :receiver, polymorphic: true

  validates :message, presence: true
  #after create commit broadcast
end