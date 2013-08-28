class AddPhoneToFacultyMembers < ActiveRecord::Migration
  def change
    add_column :faculty_members, :phone, :integer
  end
end
