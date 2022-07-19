# frozen_string_literal: true

class ContactPresenter < ApplicationPresenter
  ATTRS = %i[id salesforce_id email first_name last_name phone account_id].freeze
end
