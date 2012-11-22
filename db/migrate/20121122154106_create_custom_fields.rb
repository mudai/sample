class CreateCustomFields < ActiveRecord::Migration
  def change
    create_table :custom_fields do |t|
      t.string :type
      t.string :name
      t.string :field_format
      t.text :possible_values
      t.string :regexp
      t.integer :min_length
      t.integer :max_length
      t.boolean :is_required
      t.integer :position
      t.text :default_value
      t.boolean :editable
      t.timestamps
    end

    add_index :custom_fields, [:id, :type]
  end
end
