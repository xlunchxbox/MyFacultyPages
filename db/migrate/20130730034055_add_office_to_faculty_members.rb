class AddOfficeToFacultyMembers < ActiveRecord::Migration
  def change
    add_column :faculty_members, :office, :string
  end
end
