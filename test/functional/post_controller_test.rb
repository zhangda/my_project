require 'test_helper'

class PostControllerTest < ActionController::TestCase
  test "should get title:string" do
    get :title:string
    assert_response :success
  end

  test "should get content:text" do
    get :content:text
    assert_response :success
  end

end
