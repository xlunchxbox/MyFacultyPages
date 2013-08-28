class AddFacultyMemberIdToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :faculty_member_id, :integer
  end
end
