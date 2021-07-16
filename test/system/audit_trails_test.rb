require "application_system_test_case"

class AuditTrailsTest < ApplicationSystemTestCase
  setup do
    @audit_trail = audit_trails(:one)
  end

  test "visiting the index" do
    visit audit_trails_url
    assert_selector "h1", text: "Audit Trails"
  end

  test "creating a Audit trail" do
    visit audit_trails_url
    click_on "New Audit Trail"

    fill_in "Action", with: @audit_trail.action
    fill_in "Browser", with: @audit_trail.browser
    fill_in "Controller", with: @audit_trail.controller
    fill_in "Description", with: @audit_trail.description
    fill_in "Ip address", with: @audit_trail.ip_address
    fill_in "User", with: @audit_trail.user
    click_on "Create Audit trail"

    assert_text "Audit trail was successfully created"
    click_on "Back"
  end

  test "updating a Audit trail" do
    visit audit_trails_url
    click_on "Edit", match: :first

    fill_in "Action", with: @audit_trail.action
    fill_in "Browser", with: @audit_trail.browser
    fill_in "Controller", with: @audit_trail.controller
    fill_in "Description", with: @audit_trail.description
    fill_in "Ip address", with: @audit_trail.ip_address
    fill_in "User", with: @audit_trail.user
    click_on "Update Audit trail"

    assert_text "Audit trail was successfully updated"
    click_on "Back"
  end

  test "destroying a Audit trail" do
    visit audit_trails_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Audit trail was successfully destroyed"
  end
end
