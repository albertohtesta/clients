# frozen_string_literal: true

class ManagerAccountsPresenter < ApplicationPresenter
  ATTRS = %i[id name].freeze
  METHODS = %i[location last_follow_up_text].freeze

  def location
    city
  end

  def last_follow_up_text
    "#{(Date.today - last_follow_up).to_i} days ago"
  end

  def role_debt
    # TODO: do rebase to uncoment here
    # team_requirements.where(collaborator_id: nil).count
    (1..5).rand
  end
end
