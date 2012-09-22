class CreateAccomplishments < ActiveRecord::Migration
  def change
    create_table :accomplishments do |t|
      t.text :description
      t.integer :poster_id
      t.integer :receiver_id
      t.integer :scope_id 
      t.timestamps
    end
  end
end
