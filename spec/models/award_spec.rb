require 'spec_helper'

describe Award do
  before(:each) do
    @faculty = FactoryGirl.create(:faculty_member)
    @attr = { :title => 'Best Foo Award', :issuer => 'Foo Products, Inc.', :issue_date => Date.today,
      :faculty_member_id => @faculty.id, :summary => 'Performed as best foo employee' }
  end

  describe 'instantiation' do
    it 'should require a title' do
      no_title_award = Award.new(@attr.merge(:title => ''))
      no_title_award.should_not be_valid
    end

    it 'should require an issuer' do
      no_issuer_award = Award.new(@attr.merge(:issuer => ''))
      no_issuer_award.should_not be_valid
    end

    it 'should require an issue date' do
      no_date_award = Award.new(@attr.merge(:issue_date => ''))
      no_date_award.should_not be_valid
    end

    it 'should require a summary' do
      no_summary_award = Award.new(@attr.merge(:summary => ''))
      no_summary_award.should_not be_valid
    end

    it 'should require the ID of the recipient' do
      no_recipient_award = Award.new(@attr.merge(:faculty_member_id => nil))
      no_recipient_award.should_not be_valid
    end

    it 'should create an instance given valid attributes' do
    	Award.create!(@attr)
    end
  end

  describe 'with a faculty member association' do
    before(:each) do
      @award = @faculty.awards.create(@attr)
    end

    it 'should have a faculty member attribute' do
      @award.should respond_to(:faculty_member)
    end

    it 'should have the right associated faculty member' do
      @award.faculty_member_id.should == @faculty.id
      @award.faculty_member.should == @faculty
    end
  end
end
