# frozen_string_literal: true

class MetricPresenter < ApplicationPresenter
  ATTRS = %i[id from_date to_date metrics project_id indicator_type group_by].freeze
end
