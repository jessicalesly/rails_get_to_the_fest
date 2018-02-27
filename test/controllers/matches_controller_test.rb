require 'test_helper'

class MatchesControllerTest < ActionDispatch::IntegrationTest
  test "should get results" do
    get matches_results_url
    assert_response :success
  end

end
