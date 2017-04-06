require 'test_helper'

class GruopsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @gruop = gruops(:one)
  end

  test "should get index" do
    get gruops_url
    assert_response :success
  end

  test "should get new" do
    get new_gruop_url
    assert_response :success
  end

  test "should create gruop" do
    assert_difference('Gruop.count') do
      post gruops_url, params: { gruop: { name: @gruop.name, user_id: @gruop.user_id } }
    end

    assert_redirected_to gruop_url(Gruop.last)
  end

  test "should show gruop" do
    get gruop_url(@gruop)
    assert_response :success
  end

  test "should get edit" do
    get edit_gruop_url(@gruop)
    assert_response :success
  end

  test "should update gruop" do
    patch gruop_url(@gruop), params: { gruop: { name: @gruop.name, user_id: @gruop.user_id } }
    assert_redirected_to gruop_url(@gruop)
  end

  test "should destroy gruop" do
    assert_difference('Gruop.count', -1) do
      delete gruop_url(@gruop)
    end

    assert_redirected_to gruops_url
  end
end
