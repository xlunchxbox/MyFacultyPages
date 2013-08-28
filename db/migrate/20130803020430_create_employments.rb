class CreateEmployments < ActiveRecord::Migration
  def change
    create_table :employments do |t|
      t.string :company
      t.string :position
      t.date :start_date
      t.date :end_date
      t.text :summary
      t.integer :faculty_member_id

      t.timestamps
    end
  end
end
