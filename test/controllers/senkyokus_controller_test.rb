require 'test_helper'

class SenkyokusControllerTest < ActionDispatch::IntegrationTest
  setup do
    @senkyoku = senkyokus(:one)
  end

  test "should get index" do
    get senkyokus_url
    assert_response :success
  end

  test "should get new" do
    get new_senkyoku_url
    assert_response :success
  end

  test "should show senkyoku" do
    get senkyoku_url(@senkyoku)
    assert_response :success
  end

  test "should get edit" do
    get edit_senkyoku_url(@senkyoku)
    assert_response :success
  end


end
