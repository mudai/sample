# -*- coding: utf-8 -*-
class CreateMonitoringHistories < ActiveRecord::Migration
  def change
    create_table :monitoring_histories do |t|
      t.references :user
      t.integer :number_of_steps
      t.float :body_weight
      t.date :recorded_on #いつの分の記録か？
      t.timestamps
    end
  end
end
