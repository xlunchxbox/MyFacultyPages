class Course < ActiveRecord::Base
  validates_presence_of :dept_code, :course_no, :name, :term, :year, :faculty_member_id

  belongs_to :faculty_member
end
