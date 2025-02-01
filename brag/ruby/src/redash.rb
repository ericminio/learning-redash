require 'httparty'

class Redash
    def initialize
        @api_key = ENV['REDASH_API_KEY']
        @base_url = ENV['REDASH_BASE_URL']
        @headers = {
            'Authorization' => "Key #{ENV['REDASH_API_KEY']}", 
            'Content-Type' => 'application/json'
        }
    end

    def get_data_source_id
        response = HTTParty.get("#{ENV['REDASH_BASE_URL']}/api/data_sources", { headers: @headers })
        data_sources = response.parsed_response
        data_sources.find { |data_source| data_source['name'] == 'data' }['id']
    end
end