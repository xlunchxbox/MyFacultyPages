class Degree < ActiveRecord::Base
  validates_presence_of :title, :field_of_study, :institution, :issue_date, :faculty_member_id
  belongs_to :faculty_member
end
