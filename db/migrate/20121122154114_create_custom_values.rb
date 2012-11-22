class CreateCustomValues < ActiveRecord::Migration
  def change
    create_table :custom_values do |t|
      t.integer :custom_field_id
      t.text :value
      t.timestamps
    end

    add_index :custom_values, :custom_field_id
  end
end
