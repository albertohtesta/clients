# frozen_string_literal: true

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins "qa-clients.nordhen.com",
            "localhost:4001",
            "arkusimpel.my.salesforce.com",
            "arkusimpel--restapidev.sandbox.lightning.force.com",
            "https://qa-core.nordhen.com",
            "https://staging-core.nordhen.com",
            "https://core.nordhen.com",
            "https://qa-core-api.nordhen.com",
            "https://staging-clients.nordhen.com",
            "https://clients.nordhen.com"
    resource "*",
      headers: :any,
      methods: %i[get post put patch delete options head]
  end
end
