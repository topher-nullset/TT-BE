class CreateTeaSubscriptions < ActiveRecord::Migration[7.0]
  def change
    create_join_table :teas, :subscriptions, table_name: :tea_subscriptions do |t|
      t.index [:tea_id, :subscription_id], unique: true

      t.timestamps
    end
  end
end
