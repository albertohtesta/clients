# frozen_string_literal: true

class ProjectsTeam < ApplicationRecord
  belongs_to :team
  belongs_to :project
end
