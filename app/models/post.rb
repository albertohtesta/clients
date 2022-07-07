# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :collaborator
  belongs_to :project
  has_one_attached :post
end
