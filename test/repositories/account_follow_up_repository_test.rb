# frozen_string_literal: true

require "test_helper"

class AccountFollowUpRepositoryTest < ActiveSupport::TestCase
  setup do
    create(:account_follow_up)
    @manager_id = Account.first.manager.id
    @repository_query = AccountFollowUpRepository.by_account_manager(@manager_id)
  end

  test "Get follow ups by account manager" do
    assert @repository_query.all.size > 0
  end

  test "Manager id requested should be the same than the follow up account manager returned" do
    follow_up = @repository_query.first
    assert_equal @manager_id, follow_up.account.manager.id
  end
end
