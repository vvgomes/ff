class RemoveThumbsUps < ActiveRecord::Migration
  def up
    drop_table :thumbs_ups
  end

  def down
    create_table :thumbs_ups do |t|
      t.integer :user_id
      t.integer :accomplishment_id
      t.timestamps
    end
  end
end
