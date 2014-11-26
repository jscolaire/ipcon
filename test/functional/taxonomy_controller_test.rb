require 'test_helper'

class TaxonomyControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
