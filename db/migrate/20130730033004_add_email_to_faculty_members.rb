class AddEmailToFacultyMembers < ActiveRecord::Migration
  def change
    add_column :faculty_members, :email, :string
  end
end
