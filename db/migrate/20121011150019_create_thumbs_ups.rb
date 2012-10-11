class CreateThumbsUps < ActiveRecord::Migration
  def change
    create_table :thumbs_ups do |t|
      t.integer :user_id
      t.integer :accomplishment_id
      t.timestamps
    end
  end
end
