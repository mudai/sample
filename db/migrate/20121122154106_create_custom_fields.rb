class CreateCustomFields < ActiveRecord::Migration
  def change
    create_table :custom_fields do |t|
      t.integer :custom_box_id
      t.string :title
      t.string :unit
      t.string :field_format
      t.text :possible_values
      t.string :regexp
      t.integer :min_length
      t.integer :max_length
      t.integer :position
      t.text :default_value
      t.timestamps
    end

    add_index :custom_fields, :custom_box_id
  end
end
