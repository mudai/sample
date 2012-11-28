class CreateCustomBoxes < ActiveRecord::Migration
  def change
    create_table :custom_boxes do |t|
      t.string :title
      t.integer :box_type
      t.boolean :is_required
      t.boolean :editable
      t.integer :position
      t.timestamps
    end
  end
end
