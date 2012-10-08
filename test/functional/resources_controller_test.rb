require 'test_helper'

class ResourcesControllerTest < ActionController::TestCase
  test "index" do
    get :index
    assert_response :success
    assert_select 'a.resource' do |resources|
      resources.each do |resource|
        assert resource['href'].include? "mailto"
      end
    end
    assert_select 'form', false
  end

  test "api index" do
    get :index, :format => :json
    assert_response :success
    resp = JSON.parse response.body

    # Check for consistency between returned objects
    resp.each do |resource|
      assert_equal resource.keys, resp[0].keys
    end
  end

  test "all busy" do
    user = a User
    Use.create_dummy! :user_id => user.id, :resource_id => 1, :start => (Time.now.utc - 5)
    Use.create_dummy! :user_id => user.id, :resource_id => 2, :start => (Time.now.utc - 5)
    get :index
    assert_response :success
    assert_select 'form'
  end 

  test "let an existing user know" do
    user = a User
    post :letmeknow #, :format => :html, :email_form => { :email => user.email }
    assert_match flash[:notice], /available/i
    assert !user.messages.empty?, "No message queued for user!"
  end

  test "let an anonymous user know" do
    target = Faker::Internet.email
    assert_difference 'User.count' do
      put :letmeknow #, { :email_form => { :email => target } }
      assert_match flash[:notice], /available/i
      assert !(User.find_by_email target).messages.empty?, "No message queued for user!"
    end
  end

end
