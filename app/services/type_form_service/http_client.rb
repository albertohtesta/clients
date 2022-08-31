# frozen_string_literal: true

module TypeFormService
  class HttpClient < ApplicationService
    def initialize
      client_params
    end

    def get(path)
      RestClient.get create_path(path),
        { content_type: :json, accept: :json, Authorization: "Bearer #{access_token}" }
      rescue
    end

    def patch(path, args)
      data = [args].to_json
      RestClient.patch create_path(path), data,
        { content_type: :json, accept: :json, Authorization: "Bearer #{access_token}" }
      rescue
    end

    def post(path, args)
      data = args.to_json
      RestClient.post create_path(path), data,
        { content_type: :json, accept: :json, Authorization: "Bearer #{access_token}" }
      rescue
    end

    private
      attr_reader :access_token, :base_url

      def client_params
        @base_url = "https://api.typeform.com/"
        @access_token = ENV["TYPE_FORM_ACCESS_TOKEN"]
      end

      def create_path(value)
        base_url + value
      end
  end
end
