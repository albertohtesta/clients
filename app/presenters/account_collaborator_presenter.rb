# frozen_string_literal: true

class AccountCollaboratorPresenter < ApplicationPresenter
  METHODS = %i[contact]

  private
    def contact
      {
        id: collaborator.id,
        first_name: collaborator.first_name,
        last_name: collaborator.last_name,
        email: collaborator.email,
        phone: collaborator.phone,
        position: collaborator.role.name,
      }
    end
end
