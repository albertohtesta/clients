# frozen_string_literal: true

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins "qa-clients.nordhen.com", "localhost:4001", "arkusimpel.my.salesforce.com"

    resource "*",
      headers: :any,
      methods: %i[get post put patch delete options head]
  end
end
