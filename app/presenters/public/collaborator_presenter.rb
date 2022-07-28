# frozen_string_literal: true

module Public
  class CollaboratorPresenter < ApplicationPresenter
    ATTRS = %i[id first_name last_name role uuid position seniority english_level about work_modality].freeze
    METHODS = %i[collaborator_badges].freeze

    def collaborator_badges
      BadgePresenter.json_collection(badges)
    end
  end
end
