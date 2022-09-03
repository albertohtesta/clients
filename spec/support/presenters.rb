# frozen_string_literal: true

RSpec.configure do |config|
  config.include RSpec::Rails::RailsExampleGroup, example_group: {
    file_path: %r{spec/presenters}
  }
  config.include ActionView::TestCase::Behavior, example_group: {
    file_path: %r{spec/presenters}
  }
  config.include RSpec::Rails::Matchers::RenderTemplate, example_group: {
    file_path: %r{spec/presenters}
  }
end
