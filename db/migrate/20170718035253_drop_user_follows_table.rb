class DropUserFollowsTable < ActiveRecord::Migration[5.1]
  def change
    drop_table :user_follows
  end
end
