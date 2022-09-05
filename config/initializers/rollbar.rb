Rollbar.configure do |config|
  config.access_token = 'd1d0488b22cd4ef797dc5b3357be230b'

  # Here we'll disable in 'test':
  if Rails.env.test?
    config.enabled = false
  end

  config.environment = ENV['ROLLBAR_ENV'].presence || Rails.env
end
