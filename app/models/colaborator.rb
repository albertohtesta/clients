# frozen_string_literal: true

class Colaborator < ApplicationRecord
  validates :name, :email, :uuid, presence: true
end
