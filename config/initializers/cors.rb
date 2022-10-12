# frozen_string_literal: true

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins "localhost:4001",
            "arkusimpel.my.salesforce.com",
            "arkusimpel--restapidev.sandbox.lightning.force.com",
            "https://qa-clients.nordhen.com",
            "https://qa-clients-api.nordhen.com",
            "https://staging-clients.nordhen.com",
            "https://staging-clients-api.nordhen.com",
            "https://clients-api.nordhen.com",
            "https://clients.nordhen.com",
            "https://qa-core.nordhen.com",
            "https://staging-core.nordhen.com",
            "https://core.nordhen.com",
            "https://nordhen.com",
            "https://api.nordhen.com",
            "https://qa-core-api.nordhen.com"
    resource "*",
      headers: :any,
      methods: %i[get post put patch delete options head]
  end
end
