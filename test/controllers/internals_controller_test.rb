require 'test_helper'

class InternalsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @internal = internals(:one)
  end

  test "should get index" do
    get internals_url
    assert_response :success
  end

  test "should get new" do
    get new_internal_url
    assert_response :success
  end

  test "should create internal" do
    assert_difference('Internal.count') do
      post internals_url, params: { internal: { penguji: @internal.penguji, tgl_testing: @internal.tgl_testing } }
    end

    assert_redirected_to internal_url(Internal.last)
  end

  test "should show internal" do
    get internal_url(@internal)
    assert_response :success
  end

  test "should get edit" do
    get edit_internal_url(@internal)
    assert_response :success
  end

  test "should update internal" do
    patch internal_url(@internal), params: { internal: { penguji: @internal.penguji, tgl_testing: @internal.tgl_testing } }
    assert_redirected_to internal_url(@internal)
  end

  test "should destroy internal" do
    assert_difference('Internal.count', -1) do
      delete internal_url(@internal)
    end

    assert_redirected_to internals_url
  end
end
