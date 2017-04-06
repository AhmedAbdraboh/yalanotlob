require 'test_helper'

class OrdermembersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ordermember = ordermembers(:one)
  end

  test "should get index" do
    get ordermembers_url
    assert_response :success
  end

  test "should get new" do
    get new_ordermember_url
    assert_response :success
  end

  test "should create ordermember" do
    assert_difference('Ordermember.count') do
      post ordermembers_url, params: { ordermember: { order_id: @ordermember.order_id, status: @ordermember.status, user_id: @ordermember.user_id } }
    end

    assert_redirected_to ordermember_url(Ordermember.last)
  end

  test "should show ordermember" do
    get ordermember_url(@ordermember)
    assert_response :success
  end

  test "should get edit" do
    get edit_ordermember_url(@ordermember)
    assert_response :success
  end

  test "should update ordermember" do
    patch ordermember_url(@ordermember), params: { ordermember: { order_id: @ordermember.order_id, status: @ordermember.status, user_id: @ordermember.user_id } }
    assert_redirected_to ordermember_url(@ordermember)
  end

  test "should destroy ordermember" do
    assert_difference('Ordermember.count', -1) do
      delete ordermember_url(@ordermember)
    end

    assert_redirected_to ordermembers_url
  end
end
