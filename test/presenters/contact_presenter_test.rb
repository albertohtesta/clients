# frozen_string_literal: true

require "test_helper"

class AccountPresenterTest < ActiveSupport::TestCase
  def contact
    @contact ||= build(:contact)
  end

  def account_presenter
    @account_presenter ||= ContactPresenter.new(@contact)
  end

  test "must return json" do
    contact
    account_presenter

    expected_json = {
      "id" => nil,
      "first_name" => @contact.first_name,
      "last_name" => @contact.last_name,
      "email" => @contact.email,
      "salesforce_id" => @contact.salesforce_id,
      "phone" => @contact.phone,
      "account_id" => @contact.id
    }

    assert_equal expected_json, account_presenter.json
  end
end
