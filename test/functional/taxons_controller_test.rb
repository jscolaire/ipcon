require 'test_helper'

class TaxonsControllerTest < ActionController::TestCase
  setup do
    @taxon = taxons(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:taxons)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create taxon" do
    assert_difference('Taxon.count') do
      post :create, taxon: { name: @taxon.name, taxon_id: @taxon.taxon_id, taxontype_id: @taxon.taxontype_id }
    end

    assert_redirected_to taxon_path(assigns(:taxon))
  end

  test "should show taxon" do
    get :show, id: @taxon
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @taxon
    assert_response :success
  end

  test "should update taxon" do
    put :update, id: @taxon, taxon: { name: @taxon.name, taxon_id: @taxon.taxon_id, taxontype_id: @taxon.taxontype_id }
    assert_redirected_to taxon_path(assigns(:taxon))
  end

  test "should destroy taxon" do
    assert_difference('Taxon.count', -1) do
      delete :destroy, id: @taxon
    end

    assert_redirected_to taxons_path
  end
end
