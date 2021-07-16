require 'test_helper'

class WorkActivitiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @work_activity = work_activities(:one)
  end

  test "should get index" do
    get work_activities_url
    assert_response :success
  end

  test "should get new" do
    get new_work_activity_url
    assert_response :success
  end

  test "should create work_activity" do
    assert_difference('WorkActivity.count') do
      post work_activities_url, params: { work_activity: { aktivitas: @work_activity.aktivitas, periode_waktu: @work_activity.periode_waktu, staff_id: @work_activity.staff_id, waktu_per_aktivitas: @work_activity.waktu_per_aktivitas } }
    end

    assert_redirected_to work_activity_url(WorkActivity.last)
  end

  test "should show work_activity" do
    get work_activity_url(@work_activity)
    assert_response :success
  end

  test "should get edit" do
    get edit_work_activity_url(@work_activity)
    assert_response :success
  end

  test "should update work_activity" do
    patch work_activity_url(@work_activity), params: { work_activity: { aktivitas: @work_activity.aktivitas, periode_waktu: @work_activity.periode_waktu, staff_id: @work_activity.staff_id, waktu_per_aktivitas: @work_activity.waktu_per_aktivitas } }
    assert_redirected_to work_activity_url(@work_activity)
  end

  test "should destroy work_activity" do
    assert_difference('WorkActivity.count', -1) do
      delete work_activity_url(@work_activity)
    end

    assert_redirected_to work_activities_url
  end
end
