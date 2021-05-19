class AddExpiredAtToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :expired_at, :datetime, null: false,
    default: Time.zone.now.end_of_week
  end
end
