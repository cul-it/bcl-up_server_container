# frozen_string_literal: true

require 'aws-sdk-s3'

namespace :setup_env do
  desc 'Download rails env file.'
  task :fetch do
    target = File.join(Rails.root, '.env')
    if File.exist?(target)
      puts '.env already exists.'
    else
      puts 'Downloading .env from S3.'
      bucket = 'bcl-up'
      key = "#{ENV.fetch('RAILS_ENV', 'development')}.env"
      target = File.join(Rails.root, '.env')

      client = Aws::S3::Client.new
      client.get_object({ bucket:, key: }, target:)
    end
  end
end
