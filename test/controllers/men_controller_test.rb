require 'test_helper'

class MenControllerTest < ActionDispatch::IntegrationTest
  setup do
    @man = men(:one)
  end

  test "should get index" do
    get men_url
    assert_response :success
  end

  test "should get new" do
    get new_man_url
    assert_response :success
  end

  test "should create man" do
    assert_difference('Man.count') do
      post men_url, params: { man: { name: @man.name } }
    end

    assert_redirected_to man_url(Man.last)
  end

  test "should show man" do
    get man_url(@man)
    assert_response :success
  end

  test "should get edit" do
    get edit_man_url(@man)
    assert_response :success
  end

  test "should update man" do
    patch man_url(@man), params: { man: { name: @man.name } }
    assert_redirected_to man_url(@man)
  end

  test "should destroy man" do
    assert_difference('Man.count', -1) do
      delete man_url(@man)
    end

    assert_redirected_to men_url
  end
end
