# frozen_string_literal: true

class Collaborator < ApplicationRecord
  validates :name, :email, :uuid, presence: true
end
