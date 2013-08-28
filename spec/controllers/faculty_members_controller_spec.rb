require 'spec_helper'

describe FacultyMembersController do
  render_views  

  describe "GET request for 'index'" do
    it 'should be successful' do
      get :index
      response.should be_success
    end
  end

  describe "GET request for 'show'" do
    before(:each) do
      @faculty = FactoryGirl.create(:faculty_member)
    end

    it 'should be successful' do
      get :show, :id => @faculty
      response.should be_success
    end

    it 'should have the correct title' do
      get :show, :id => @faculty
      response.should have_selector('title', 
        :content => "#{@faculty.first_name} #{@faculty.last_name}")
    end
  end

  describe "GET request for 'courses'" do
    before(:each) do
      @faculty = FactoryGirl.create(:faculty_member)
    end

    it 'should be successful' do
      get :courses, :id => @faculty
      response.should be_success
    end

    it 'should have the correct title' do
      get :courses, :id => @faculty
      response.should have_selector('title', 
        :content => "Courses taught by #{@faculty.first_name} #{@faculty.last_name}")
    end
  end

  describe "GET request for 'researches'" do
    before(:each) do
      @faculty = FactoryGirl.create(:faculty_member)
    end

    it 'should be successful' do
      get :researches, :id => @faculty
      response.should be_success
    end

    it 'should have the correct title' do
      get :researches, :id => @faculty
      response.should have_selector('title',
        :content => "Research by #{@faculty.first_name} #{@faculty.last_name}")
    end
  end

  describe "GET request for 'publications'" do
    before(:each) do
      @faculty = FactoryGirl.create(:faculty_member)
    end

    it 'should be successful' do
      get :publications, :id => @faculty
      response.should be_success
    end

    it 'should have the correct title' do
      get :publications, :id => @faculty
      response.should have_selector('title',
        :content => "Publications by #{@faculty.first_name} #{@faculty.last_name}")
    end
  end

  describe "GET request for 'curriculum vitae'" do
    before(:each) do
      @faculty = FactoryGirl.create(:faculty_member)
    end

    it 'should be successful' do
      get :curriculum_vitae, :id => @faculty
      response.should be_success
    end

    it 'should have the correct title' do
      get :curriculum_vitae, :id => @faculty
      response.should have_selector('title', 
        :content => "Curriculum Vitae for #{@faculty.first_name} #{@faculty.last_name}")
    end
  end

  describe "GET request for 'contact details'" do
    before(:each) do
      @faculty = FactoryGirl.create(:faculty_member)
    end

    it 'should be successful' do
      get :contact_details, :id => @faculty
      response.should be_success
    end

    it 'should have the correct title' do
      get :contact_details, :id => @faculty
      response.should have_selector('title',
        :content => "Contact Details for #{@faculty.first_name} #{@faculty.last_name}")
    end
  end

  describe "GET request for 'edit'" do
    before(:each) do
      @faculty = FactoryGirl.create(:faculty_member)
    end

    describe 'for users not signed in' do
      it 'should deny access' do
        get :edit, :id => @faculty
        response.should redirect_to(signin_path)
      end
    end

    describe 'for faculty members signed in' do
      before(:each) { controller.sign_in(@faculty) }

      it 'should be successful' do
        get :edit, :id => @faculty
        response.should be_success
      end

      it 'should have the right title' do
        get :edit, :id => @faculty
        response.should have_selector('title', :content => 'Edit profile')
      end
    end
  end

  describe "PATCH request for 'update'" do
    before(:each) do
      @faculty = FactoryGirl.create(:faculty_member)
    end

    describe 'for users not signed in' do
      before do
        @attr = { :first_name => 'FooFirst', :last_name => 'FooLast' }
      end

      it 'should deny access' do
        patch :update, :id => @faculty, :faculty_member => @attr
        response.should redirect_to(signin_path)
      end
    end

    describe 'failure' do
      before(:each) do
        @attr = { :first_name => '', :last_name => '', :password => '', :password_confirmation => '' }
        controller.sign_in(@faculty)
      end

      it "should render the 'edit' page" do
        patch :update, :id => @faculty, :faculty_member => @attr
        response.should render_template('edit')
      end

      it 'should have the right title' do
        patch :update, :id => @faculty, :faculty_member => @attr
        response.should have_selector('title', :content => 'Edit profile')
      end
    end

    describe 'success' do
      before(:each) do
        @attr = { :first_name => 'NewFooFirst', :last_name => 'NewFooLast', :password => 'NewFoobar', 
          :password_confirmation => 'NewFoobar' }
        controller.sign_in(@faculty)
      end

      it "should change the faculty member's attributes" do
        patch :update, :id => @faculty, :faculty_member => @attr
        @faculty.reload
        @faculty.first_name.should == @attr[:first_name]
        @faculty.last_name.should == @attr[:last_name]
      end

      it "should redirect to the faculty member's home page" do
        put :update, :id => @faculty, :faculty_member => @attr
        response.should redirect_to(faculty_member_path(@faculty))
      end

      it 'should have a flash notification indicating success' do
        put :update, :id => @faculty, :faculty_member => @attr
        flash[:success].should =~ /updated/
      end
    end
  end

  describe 'authentication of restricted CRUD pages' do
    before(:each) do
      @one_faculty = FactoryGirl.create(:faculty_member)
      @wrong_faculty = FactoryGirl.create(:faculty_member, :university_id => 789098, :email => 'foo@example.net',
        :phone => 1112223333)
      controller.sign_in(@wrong_faculty)
    end

    it "should require matching faculty members for 'edit'" do
      get :edit, :id => @one_faculty
      response.should redirect_to(@wrong_faculty)
    end

    it "should require matching faculty members for 'update'" do
      patch :update, :id => @one_faculty, :faculty_member => {}
      response.should redirect_to(@wrong_faculty)
    end
  end
end
