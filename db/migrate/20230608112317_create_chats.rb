class CreateChats < ActiveRecord::Migration[6.0]
  def change
    create_table :chats do |t|
      t.text :message
      t.references :sender, polymorphic: true, null: false
      t.references :receiver, polymorphic: true, null: false
    end
  end
end
