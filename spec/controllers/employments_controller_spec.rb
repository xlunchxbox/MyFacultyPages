require 'spec_helper'

describe EmploymentsController do
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
	  		response.should have_selector('title', :content => 'Add employment')
	  	end
    end

  	describe "GET request for 'edit'" do
	  	before(:each) do
	  		@employment = FactoryGirl.create(:employment, :faculty_member => @faculty)
	  	end

	  	it 'should be successful' do
	  		get :edit, :id => @employment
	  		response.should be_success
	  	end

	  	it 'should have the correct title' do
  			get :edit, :id => @employment
	  		response.should have_selector('title', :content => 'Edit employment')
  		end
  	end

	  describe "POST request for 'create'" do
		  describe 'failure' do
			  before(:each) do
				  @attr = { :company => '', :position => '', :start_date => nil, :end_date => nil, 
            :summary => '' }
			  end

			  it 'should not create an invalid employment' do
				  lambda do
					  post :create, :employment => @attr
				  end.should_not change(Employment, :count)
		  	end

			  it 'should have the correct title' do
				  post :create, :employment => @attr
				  response.should have_selector('title', :content => 'Add employment')
			  end

			  it "should render the 'new' page" do
				  post :create, :employment => @attr
				  response.should render_template('new')
			  end
		  end

		  describe 'success' do
			  before(:each) do
				  @attr = { :company => 'Foo Company Name', :position => 'Foo position', 
            :start_date => Date.new(2000, 1, 2), :end_date => Date.today, :summary => 'Foo summary',
            :faculty_member_id => @faculty.id }
			  end

			  it 'should create a employment' do
				  lambda do
					  post :create, :employment => @attr
				  end.should change(Employment, :count).by(1)
			  end

			  it "should redirect to the faculty member's employments page" do
				  post :create, :employment => @attr
				  response.should redirect_to(curriculum_vitae_faculty_member_path(@faculty))
			  end
		  end
	  end

	  describe "PATCH request for 'update'" do
		  before(:each) do
			  @employment = FactoryGirl.create(:employment, :faculty_member => @faculty)
		  end

		  describe 'failure' do
			  before(:each) do
				  @attr = { :company => '', :position => '' }
			  end

			  it "should render the 'edit' page" do
				  patch :update, :id => @employment, :employment => @attr
				  response.should render_template('edit')
			  end

			  it 'should have the right title' do
				  patch :update, :id => @employment, :employment => @attr
				  response.should have_selector('title', :content => 'Edit employment')
			  end
		  end

		  describe 'success' do
			  before(:each) do
				  @attr = { :company => 'New Foo Company Name', :position => 'New foo position' }
			  end

			  it "should change the employment's attributes" do
				  patch :update, :id => @employment, :employment => @attr
				  @employment.reload
				  @employment.company.should == @attr[:company]
				  @employment.position.should == @attr[:position]
			  end

			  it "should redirect to the faculty member's employments page" do
				  patch :update, :id => @employment, :employment => @attr
				  response.should redirect_to(curriculum_vitae_faculty_member_path(@faculty))
			  end
		  end
	  end

	  describe "DELETE request for 'destroy'" do
		  before(:each) do
			  @employment = FactoryGirl.create(:employment, :faculty_member => @faculty)
		  end

		  it 'should delete the employment' do
			  lambda do
			  	delete :destroy, :id => @employment
			  end.should change(Employment, :count).by(-1)
		  end

		  it "should redirect to the faculty member's employments page" do
			  delete :destroy, :id => @employment
			  response.should redirect_to(curriculum_vitae_faculty_member_path(@faculty))
		  end
	  end
  end

  describe 'for users not signed in' do
  	before(:each) do
  		@employment = FactoryGirl.create(:employment, :faculty_member => @faculty)
  	end

  	it "should deny access to GET 'new'" do
  		get :new
  		response.should redirect_to(signin_path)
  	end

  	it "should deny access to GET 'edit'" do
  		get :edit, :id => @employment
  		response.should redirect_to(signin_path)
  	end

  	it "should deny access to POST 'create'" do
  		@attr = { :company => 'Foo Company Name', :position => 'Foo position', 
        :start_date => Date.new(2000, 1, 2), :end_date => Date.today, :summary => 'Foo summary',
        :faculty_member_id => @faculty.id }
  		post :create, :employment => @attr
  		response.should redirect_to(signin_path)
  	end

  	it "should deny access to PATCH 'update'" do
  		patch :update, :id => @employment, :employment => {}
  		response.should redirect_to(signin_path)
  	end

  	it "should deny access to DELETE 'destroy'" do
  		delete :destroy, :id => @employment
  		response.should redirect_to(signin_path)
  	end
  end
end


