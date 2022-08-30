# frozen_string_literal: true

class AccountContactCollaboratorPresenter < ApplicationPresenter
  METHODS = %i[id first_name last_name email phone position img].freeze

  def id
    collaborator.id
  end

  def first_name
    collaborator.first_name
  end

  def last_name
    collaborator.last_name
  end

  def email
    collaborator.email
  end

  def phone
    collaborator.phone
  end

  def position
    collaborator.role.name
  end

  def img
    collaborator.profile
  end
end
