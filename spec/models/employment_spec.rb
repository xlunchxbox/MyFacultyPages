require 'spec_helper'

describe Employment do
  before(:each) do
    @attr = { :company => 'Foo Company', :position => 'Foo Developer', :start_date => Date.new(2001, 1, 1),
      :end_date => Date.today, :summary => 'Worked as a foo developer', :faculty_member_id => 1 }
  end

  describe 'instantiation' do
    it 'should require a company name' do
      no_company_employment = Employment.new(@attr.merge(:company => ''))
      no_company_employment.should_not be_valid
    end

    it 'should require a position' do
      no_position_employment = Employment.new(@attr.merge(:position => ''))
      no_position_employment.should_not be_valid
    end

    it 'should require a starting date' do
      no_start_date_employment = Employment.new(@attr.merge(:start_date => nil))
      no_start_date_employment.should_not be_valid
    end

    it 'should require a summary' do
      no_summary_employment = Employment.new(@attr.merge(:summary => ''))
      no_summary_employment.should_not be_valid
    end

    it 'should require a faculty ID reference' do
      no_faculty_reference_employment = Employment.new(@attr.merge(:faculty_member_id => nil))
      no_faculty_reference_employment.should_not be_valid
    end

    it 'should create an instance given valid attributes' do
      Employment.create!(@attr)
    end
  end

  describe 'with faculty member associations' do
  	before(:each) do
  		@faculty = FactoryGirl.create(:faculty_member)
  		@employment = @faculty.employments.create(@attr)
  	end

  	it 'should have a faculty member attribute' do
  		@employment.should respond_to(:faculty_member)
  	end

  	it 'should have the right associated faculty member' do
  		@employment.faculty_member_id.should == @faculty.id
  		@employment.faculty_member.should == @faculty
  	end
  end
end
