class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :dept_code
      t.integer :course_no
      t.string :name
      t.string :term
      t.integer :year
      t.text :summary

      t.timestamps
    end
  end
end
