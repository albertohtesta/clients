# frozen_string_literal: true

module TypeFormService
  class HttpClient < ApplicationService
    def initialize
      @base_url = "https://api.typeform.com/"
      @access_token = ENV["TYPE_FORM_ACCESS_TOKEN"]
    end

    def get(path)
      path = @base_url + path
      begin
        response = RestClient.get path,
        { content_type: :json, accept: :json, Authorization: "Bearer #{access_token}" }
      rescue RestClient::ExceptionWithResponse
        return nil
      end
      response
    end

    def patch(path, args)
      path = @base_url + path
      data = [args].to_json
      begin
        response = RestClient.patch path, data,
        { content_type: :json, accept: :json, Authorization: "Bearer #{access_token}" }
      rescue RestClient::ExceptionWithResponse
        return nil
      end
      response
    end

    def post(path, args)
      path = @base_url + path
      data = args.to_json
      begin
        response = RestClient.post path, data,
        { content_type: :json, accept: :json, Authorization: "Bearer #{access_token}" }
      rescue RestClient::ExceptionWithResponse
        return nil
      end
      response
    end

    private
      attr_reader :access_token, :base_url
  end
end
