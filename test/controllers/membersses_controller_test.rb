require 'test_helper'

class MemberssesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @memberss = membersses(:one)
  end

  test "should get index" do
    get membersses_url
    assert_response :success
  end

  test "should get new" do
    get new_memberss_url
    assert_response :success
  end

  test "should create memberss" do
    assert_difference('Memberss.count') do
      post membersses_url, params: { memberss: { gruop_id: @memberss.gruop_id, user_id: @memberss.user_id } }
    end

    assert_redirected_to memberss_url(Memberss.last)
  end

  test "should show memberss" do
    get memberss_url(@memberss)
    assert_response :success
  end

  test "should get edit" do
    get edit_memberss_url(@memberss)
    assert_response :success
  end

  test "should update memberss" do
    patch memberss_url(@memberss), params: { memberss: { gruop_id: @memberss.gruop_id, user_id: @memberss.user_id } }
    assert_redirected_to memberss_url(@memberss)
  end

  test "should destroy memberss" do
    assert_difference('Memberss.count', -1) do
      delete memberss_url(@memberss)
    end

    assert_redirected_to membersses_url
  end
end
