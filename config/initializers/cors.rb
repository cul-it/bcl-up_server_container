# frozen_string_literal: true

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins '*' # Change this to your specific frontend domains in production

    resource '*',
      headers: :any, # This automatically mirrors requested headers, including Authorization
      methods: [:get, :post, :put, :patch, :delete, :options, :head],
      expose: ['Authorization'] # Optional: exposes the header back to the client if needed
  end
end
