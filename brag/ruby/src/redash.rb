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

    def headers
        @headers
    end

    def get_data_source_id
        response = HTTParty.get("#{ENV['REDASH_BASE_URL']}/api/data_sources", { headers: @headers })
        data_sources = response.parsed_response
        data_sources.find { |data_source| data_source['name'] == 'data' }['id']
    end

    def create_query(name, sql)
        data_source_id = get_data_source_id

        response = HTTParty.post("#{ENV['REDASH_BASE_URL']}/api/queries", {
            headers: @headers,
            body: {
                name: name,
                data_source_id: data_source_id,
                query: sql
            }.to_json
        })

        response.parsed_response
    end
end