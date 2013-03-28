require 'test_helper'

class ContactsControllerTest < ActionController::TestCase
  setup do
    @contact = contacts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:contacts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create contact_mailer" do
    assert_difference('Contact.count') do
      post :create, contact_mailer: { comments: @contact.comments, email: @contact.email, name: @contact.name }
    end

    assert_redirected_to contact_path(assigns(:contact_mailer))
  end

  test "should show contact_mailer" do
    get :show, id: @contact
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @contact
    assert_response :success
  end

  test "should update contact_mailer" do
    put :update, id: @contact, contact_mailer: { comments: @contact.comments, email: @contact.email, name: @contact.name }
    assert_redirected_to contact_path(assigns(:contact_mailer))
  end

  test "should destroy contact_mailer" do
    assert_difference('Contact.count', -1) do
      delete :destroy, id: @contact
    end

    assert_redirected_to contacts_path
  end
end
