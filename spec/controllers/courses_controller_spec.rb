require 'spec_helper'

describe CoursesController do
	render_views

	before(:each) do
		@faculty = FactoryGirl.create(:faculty_member)
	end

	describe 'for faculty members signed in' do
  	before(:each) do
  		controller.sign_in(@faculty)
  	end

  	describe "GET request for 'new'" do
  		it 'should be successful' do
	  		get :new
	  		response.should be_success
  		end

  		it 'should have the correct title' do
	  		get :new
	  		response.should have_selector('title', :content => 'Add course')
	  	end
    end

  	describe "GET request for 'edit'" do
	  	before(:each) do
	  		@course = FactoryGirl.create(:course, :faculty_member => @faculty)
	  	end

	  	it 'should be successful' do
	  		get :edit, :id => @course
	  		response.should be_success
	  	end

	  	it 'should have the correct title' do
  			get :edit, :id => @course
	  		response.should have_selector('title', :content => 'Edit course')
  		end
  	end

	  describe "POST request for 'create'" do
		  describe 'failure' do
			  before(:each) do
				  @attr = { :dept_code => '', :course_no => nil, :course_name => '', :term => '',
				    :year => nil, :summary => '' }
			  end

			  it 'should not create an invalid course' do
				  lambda do
					  post :create, :course => @attr
				  end.should_not change(Course, :count)
		  	end

			  it 'should have the correct title' do
				  post :create, :course => @attr
				  response.should have_selector('title', :content => 'Add course')
			  end

			  it "should render the 'new' page" do
				  post :create, :course => @attr
				  response.should render_template('new')
			  end
		  end

		  describe 'success' do
			  before(:each) do
				  @attr = { :dept_code => 'COSC', :course_no => 1234, :name => 'Foo', :term => 'Fall',
				    :year => 2003, :summary => 'Introduction to foo', :faculty_member_id => @faculty.id }
			  end

			  it 'should create a course' do
				  lambda do
					  post :create, :course => @attr
				  end.should change(Course, :count).by(1)
			  end

			  it "should redirect to the faculty member's courses page" do
				  post :create, :course => @attr
				  response.should redirect_to(courses_faculty_member_path(@faculty))
			  end
		  end
	  end

	  describe "PATCH request for 'update'" do
		  before(:each) do
			  @course = FactoryGirl.create(:course, :faculty_member => @faculty)
		  end

		  describe 'failure' do
			  before(:each) do
				  @attr = { :dept_code => '', :course_no => nil, :course_name => '', :term => '',
				    :year => nil, :summary => '' }
			  end

			  it "should render the 'edit' page" do
				  patch :update, :id => @course, :course => @attr
				  response.should render_template('edit')
			  end

			  it 'should have the right title' do
				  patch :update, :id => @course, :course => @attr
				  response.should have_selector('title', :content => 'Edit course')
			  end
		  end

		  describe 'success' do
			  before(:each) do
				  @attr = { :course_no => 2345, :name => 'NewFoo', :term => 'Spring' }
			  end

			  it "should change the course's attributes" do
				  patch :update, :id => @course, :course => @attr
				  @course.reload
				  @course.course_no.should == @attr[:course_no]
				  @course.name.should == @attr[:name]
				  @course.term.should == @attr[:term]
			  end

			  it "should redirect to the faculty member's courses page" do
				  patch :update, :id => @course, :course => @attr
				  response.should redirect_to(courses_faculty_member_path(@faculty))
			  end
		  end
	  end

	  describe "DELETE request for 'destroy'" do
		  before(:each) do
			  @course = FactoryGirl.create(:course, :faculty_member => @faculty)
		  end

		  it 'should delete the course' do
			  lambda do
			  	delete :destroy, :id => @course
			  end.should change(Course, :count).by(-1)
		  end

		  it "should redirect to the faculty member's courses page" do
			  delete :destroy, :id => @course
			  response.should redirect_to(courses_faculty_member_path(@faculty))
		  end
	  end
  end

  describe 'for users not signed in' do
  	before(:each) do
  		@course = FactoryGirl.create(:course, :faculty_member => @faculty)
  	end

  	it "should deny access to GET 'new'" do
  		get :new
  		response.should redirect_to(signin_path)
  	end

  	it "should deny access to GET 'edit'" do
  		get :edit, :id => @course
  		response.should redirect_to(signin_path)
  	end

  	it "should deny access to POST 'create'" do
  		@attr = { :dept_code => 'COSC', :course_no => 1234, :name => 'Foo', :term => 'Fall',
				:year => 2003, :summary => 'Introduction to foo', :faculty_member_id => @faculty.id }
  		post :create, :course => @attr
  		response.should redirect_to(signin_path)
  	end

  	it "should deny access to PATCH 'update'" do
  		@attr = { :course_no => 4567, :name => 'AnotherNewFoo' }
  		patch :update, :id => @course, :course => @attr
  		response.should redirect_to(signin_path)
  	end

  	it "should deny access to DELETE 'destroy'" do
  		delete :destroy, :id => @course
  		response.should redirect_to(signin_path)
  	end
  end
end
