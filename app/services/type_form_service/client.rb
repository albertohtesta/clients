# frozen_string_literal: true

require "net/http"

module TypeFormService
  class Client < ApplicationService
    attr_reader :base_url

    def initialize
      @base_url = "https://api.typeform.com/"
      @access_token = ENV["TYPE_FORM_ACCESS_TOKEN"]
    end

    def get(path, **args)
      # implementation for the http get request
      uri = build_uri(path, **args)
      req = Net::HTTP::Get.new(uri)
      make_request(req, uri)
    end

    def post(path, **args)
      # implementation for the http post request
      uri = build_uri(path, **args)
      req = Net::HTTP::Post.new(uri)
      make_request(req, uri)
    end

    def put(path, **args)
      # implementation for the http put request
      uri = build_uri(path, **args)
      req = Net::HTTP::Put.new(uri)
      make_request(req, uri)
    end

    def delete(path, **args)
      # implementation for the http delete request
      uri = build_uri(path, **args)
      req = Net::HTTP::Delete.new(uri)
      make_request(req, uri)
    end

    private
      attr_reader :access_token

      def make_request(req, uri)
        req["Authorization"] = "Bearer #{access_token}"
        res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) { |http| http.request(req) }
        serialize(res.body) if res.is_a?(Net::HTTPSuccess)
      end

      def serialize(content)
        JSON.parse(content, symbolize_names: true)
      rescue JSON::ParserError
        "Content could not be parsed. Actual content: \n #{content}"
      end

      def build_uri(path, **params)
        uri = URI.join(base_url, path)
        uri.query = query_items(**params)
        uri
      end

      def query_items(**options)
        query_items = options.fetch(:query, {}).compact
        URI.encode_www_form(query_items)
      end
  end
end
