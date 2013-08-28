class CreateFacultyMembers < ActiveRecord::Migration
  def change
    create_table :faculty_members do |t|
      t.string :last_name
      t.string :first_name
      t.string :position
      t.string :department
      t.text :summary
      t.text :biography
      t.integer :university_id

      t.timestamps
    end
  end
end
