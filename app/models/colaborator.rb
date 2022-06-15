class Colaborator < ApplicationRecord
  validates :name, :email, :uuid, presence: true
end
