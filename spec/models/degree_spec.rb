require 'spec_helper'

describe Degree do
  before(:each) do
    @faculty = FactoryGirl.create(:faculty_member)
    @attr = { :title => 'Ph.D', :field_of_study => 'Computer Science', :institution => 'University of Foo',
      :issue_date => Date.today, :faculty_member_id => @faculty.id }
  end

  describe 'instantiation' do
    it 'should require a title' do
      no_title_degree = Degree.new(@attr.merge(:title => ''))
      no_title_degree.should_not be_valid
    end

    it 'should require a field of study' do
      no_study_field_degree = Degree.new(@attr.merge(:field_of_study => ''))
      no_study_field_degree.should_not be_valid
    end

    it 'should require the awarding institution' do
      no_institution_degree = Degree.new(@attr.merge(:institution => ''))
      no_institution_degree.should_not be_valid
    end

    it 'should require the issue date' do
      no_issue_date_degree = Degree.new(@attr.merge(:issue_date => nil))
      no_issue_date_degree.should_not be_valid
    end
    
    it 'should require the ID of the recipient' do
      no_recipient_degree = Degree.new(@attr.merge(:faculty_member_id => nil))
      no_recipient_degree.should_not be_valid
    end

    it 'should create a new instance given valid attributes' do
      Degree.create!(@attr)
    end
  end

  describe 'with a faculty member association' do
    before(:each) do
      @degree = @faculty.degrees.create(@attr)
    end

    it 'should have a faculty member attribute' do
      @degree.should respond_to(:faculty_member)
    end

    it 'should have the right associated faculty member' do
      @degree.faculty_member_id.should == @faculty.id
      @degree.faculty_member.should == @faculty
    end
  end
end
