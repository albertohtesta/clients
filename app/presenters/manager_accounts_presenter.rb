# frozen_string_literal: true

class ManagerAccountsPresenter < ApplicationPresenter
  ATTRS = %i[id name].freeze
  METHODS = %i[location last_follow_up_text priority role_debt alert].freeze

  def location
    city
  end

  def last_follow_up_text
    return "#{(Date.today - last_follow_up).to_i} days ago" if last_follow_up

    "No follow ups found"
  end

  def role_debt
    # TODO: do rebase to uncoment here
    # team_requirements.where(collaborator_id: nil).count
    rand(0..3)
  end

  def alert
    # TODO: Needs alert depending of the priority and some rulex
    [true, false].sample
  end
end
