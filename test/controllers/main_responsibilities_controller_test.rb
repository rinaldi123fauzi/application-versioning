require 'test_helper'

class MainResponsibilitiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @main_responsibility = main_responsibilities(:one)
  end

  test "should get index" do
    get main_responsibilities_url
    assert_response :success
  end

  test "should get new" do
    get new_main_responsibility_url
    assert_response :success
  end

  test "should create main_responsibility" do
    assert_difference('MainResponsibility.count') do
      post main_responsibilities_url, params: { main_responsibility: { aktivitas: @main_responsibility.aktivitas, frekuensi: @main_responsibility.frekuensi, menit: @main_responsibility.menit, output: @main_responsibility.output, periode: @main_responsibility.periode, staff_id: @main_responsibility.staff_id, tanggung_jawab_utama: @main_responsibility.tanggung_jawab_utama } }
    end

    assert_redirected_to main_responsibility_url(MainResponsibility.last)
  end

  test "should show main_responsibility" do
    get main_responsibility_url(@main_responsibility)
    assert_response :success
  end

  test "should get edit" do
    get edit_main_responsibility_url(@main_responsibility)
    assert_response :success
  end

  test "should update main_responsibility" do
    patch main_responsibility_url(@main_responsibility), params: { main_responsibility: { aktivitas: @main_responsibility.aktivitas, frekuensi: @main_responsibility.frekuensi, menit: @main_responsibility.menit, output: @main_responsibility.output, periode: @main_responsibility.periode, staff_id: @main_responsibility.staff_id, tanggung_jawab_utama: @main_responsibility.tanggung_jawab_utama } }
    assert_redirected_to main_responsibility_url(@main_responsibility)
  end

  test "should destroy main_responsibility" do
    assert_difference('MainResponsibility.count', -1) do
      delete main_responsibility_url(@main_responsibility)
    end

    assert_redirected_to main_responsibilities_url
  end
end
