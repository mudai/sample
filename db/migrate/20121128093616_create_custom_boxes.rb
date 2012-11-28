class CreateCustomBoxes < ActiveRecord::Migration
  def change
    create_table :custom_boxes do |t|
      t.string :title
      t.string :type
      t.boolean :is_required
      t.boolean :editable
      t.integer :position
      t.timestamps
    end
  end
end
