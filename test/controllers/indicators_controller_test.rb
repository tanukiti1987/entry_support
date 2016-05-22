require 'test_helper'

class IndicatorsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @indicator = indicators(:one)
  end

  test "should get index" do
    get indicators_url
    assert_response :success
  end

  test "should create indicator" do
    assert_difference('Indicator.count') do
      post indicators_url, params: { indicator: { trend: @indicator.trend } }
    end

    assert_response 201
  end

  test "should show indicator" do
    get indicator_url(@indicator)
    assert_response :success
  end

  test "should update indicator" do
    patch indicator_url(@indicator), params: { indicator: { trend: @indicator.trend } }
    assert_response 200
  end

  test "should destroy indicator" do
    assert_difference('Indicator.count', -1) do
      delete indicator_url(@indicator)
    end

    assert_response 204
  end
end
