class CreateMonitoringHistories < ActiveRecord::Migration
  def change
    create_table :monitoring_histories do |t|
      t.references :user
      t.integer :number_of_steps
      t.float :body_weight
      t.timestamps
    end
  end
end
