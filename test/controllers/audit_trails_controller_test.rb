require 'test_helper'

class AuditTrailsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @audit_trail = audit_trails(:one)
  end

  test "should get index" do
    get audit_trails_url
    assert_response :success
  end

  test "should get new" do
    get new_audit_trail_url
    assert_response :success
  end

  test "should create audit_trail" do
    assert_difference('AuditTrail.count') do
      post audit_trails_url, params: { audit_trail: { action: @audit_trail.action, browser: @audit_trail.browser, controller: @audit_trail.controller, description: @audit_trail.description, ip_address: @audit_trail.ip_address, user: @audit_trail.user } }
    end

    assert_redirected_to audit_trail_url(AuditTrail.last)
  end

  test "should show audit_trail" do
    get audit_trail_url(@audit_trail)
    assert_response :success
  end

  test "should get edit" do
    get edit_audit_trail_url(@audit_trail)
    assert_response :success
  end

  test "should update audit_trail" do
    patch audit_trail_url(@audit_trail), params: { audit_trail: { action: @audit_trail.action, browser: @audit_trail.browser, controller: @audit_trail.controller, description: @audit_trail.description, ip_address: @audit_trail.ip_address, user: @audit_trail.user } }
    assert_redirected_to audit_trail_url(@audit_trail)
  end

  test "should destroy audit_trail" do
    assert_difference('AuditTrail.count', -1) do
      delete audit_trail_url(@audit_trail)
    end

    assert_redirected_to audit_trails_url
  end
end
