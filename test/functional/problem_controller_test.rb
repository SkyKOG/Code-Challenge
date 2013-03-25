require 'test_helper'

class ProblemControllerTest < ActionController::TestCase
  test "should get browse" do
    get :browse
    assert_response :success
  end

  test "should get show" do
    get :show
    assert_response :success
  end

  test "should get answer" do
    get :answer
    assert_response :success
  end

  test "should get result" do
    get :result
    assert_response :success
  end

end
