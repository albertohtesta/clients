# frozen_string_literal: true

class CollaboratorPresenter < ApplicationPresenter
  def self.json(object)
    object.serializable_hash(
      only: %i[id name email],
      methods: [:accounts_count],
      include: [accounts: { only:
        %i[id name contact_name contact_email account_web_page],
                            methods: %i[review_outdated? location tech_stacks
                                        tools payment_status status details finance health productivity_kpis] }]
    )
  end
end
