require "application_system_test_case"

class WorkActivitiesTest < ApplicationSystemTestCase
  setup do
    @work_activity = work_activities(:one)
  end

  test "visiting the index" do
    visit work_activities_url
    assert_selector "h1", text: "Work Activities"
  end

  test "creating a Work activity" do
    visit work_activities_url
    click_on "New Work Activity"

    fill_in "Aktivitas", with: @work_activity.aktivitas
    fill_in "Periode waktu", with: @work_activity.periode_waktu
    fill_in "Staff", with: @work_activity.staff_id
    fill_in "Waktu per aktivitas", with: @work_activity.waktu_per_aktivitas
    click_on "Create Work activity"

    assert_text "Work activity was successfully created"
    click_on "Back"
  end

  test "updating a Work activity" do
    visit work_activities_url
    click_on "Edit", match: :first

    fill_in "Aktivitas", with: @work_activity.aktivitas
    fill_in "Periode waktu", with: @work_activity.periode_waktu
    fill_in "Staff", with: @work_activity.staff_id
    fill_in "Waktu per aktivitas", with: @work_activity.waktu_per_aktivitas
    click_on "Update Work activity"

    assert_text "Work activity was successfully updated"
    click_on "Back"
  end

  test "destroying a Work activity" do
    visit work_activities_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Work activity was successfully destroyed"
  end
end
