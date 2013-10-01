class CreatePlusOnes < ActiveRecord::Migration
  def change
    create_table :plus_ones do |t|
      t.integer :accomplishment_id
      t.integer :user_id
    end
  end
end
