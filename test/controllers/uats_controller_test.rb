require 'test_helper'

class UatsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @uat = uats(:one)
  end

  test "should get index" do
    get uats_url
    assert_response :success
  end

  test "should get new" do
    get new_uat_url
    assert_response :success
  end

  test "should create uat" do
    assert_difference('Uat.count') do
      post uats_url, params: { uat: { no_testing: @uat.no_testing, penguji: @uat.penguji, tgl_testing: @uat.tgl_testing } }
    end

    assert_redirected_to uat_url(Uat.last)
  end

  test "should show uat" do
    get uat_url(@uat)
    assert_response :success
  end

  test "should get edit" do
    get edit_uat_url(@uat)
    assert_response :success
  end

  test "should update uat" do
    patch uat_url(@uat), params: { uat: { no_testing: @uat.no_testing, penguji: @uat.penguji, tgl_testing: @uat.tgl_testing } }
    assert_redirected_to uat_url(@uat)
  end

  test "should destroy uat" do
    assert_difference('Uat.count', -1) do
      delete uat_url(@uat)
    end

    assert_redirected_to uats_url
  end
end
