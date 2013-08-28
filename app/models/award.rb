class Award < ActiveRecord::Base
  validates_presence_of :title, :issuer, :issue_date, :summary, :faculty_member_id

  belongs_to :faculty_member
end
