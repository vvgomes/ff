class AddGroupIdToAccomplishments < ActiveRecord::Migration
  def change
    add_column :accomplishments, :group_id, :integer
  end
end
