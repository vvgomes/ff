class CreateSuggestions < ActiveRecord::Migration
  def change
    create_table :suggestions do |t|
      t.text :description
      t.integer :sender_id
      t.integer :receiver_id
      t.timestamps
    end
  end
end
