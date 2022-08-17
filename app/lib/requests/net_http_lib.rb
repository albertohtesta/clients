# frozen_string_literal: true

require "net/http"
require "uri"

module Requests
  class NetHttpLib
    def initialize(url:)
      @uri = prepare_uri(url)
      @http = http_server
      @request = request_entity
      @response = nil
    end

    def resolve
      # response = http.request(request)
      response = Net::HTTP.get_response(@uri)
      return response.body if response.is_a?(Net::HTTPSuccess)
    end

    def with_query_params(params)
      uri.query = URI.encode_www_form(params)
      self
    end

    def with_headers(**headers)
      headers.map { |header, value| request[header.to_s] = value }
      self
    end

    attr_accessor :response

    private
      attr_reader :uri, :request, :http

      def request_entity
        Net::HTTP::Get.new(uri.request_uri)
      end

      def http_server
        Net::HTTP.new(uri.host, uri.port)
      end

      def prepare_uri(url)
        URI.parse(url)
      end
  end
end
