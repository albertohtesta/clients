# frozen_string_literal: true

# Base class for repositories
class AccountRepository < ApplicationRepository
  class << self
    def first_or_initialize_by_salesforce_id(salesforce_id)
      scope.where(salesforce_id:).first_or_initialize
    end

    def tech_stacks(model_object)
      model_object.projects.map { |project| project.tech_stacks.pluck(:name) }.flatten.uniq
    end

    def tools(model_object)
      model_object.projects.map { |project| project.tools.pluck(:name) }.flatten.uniq
    end
  end
end
