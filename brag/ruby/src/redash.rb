require 'test/unit'
require 'pg'
require 'httparty'

class TddReadyTest < Test::Unit::TestCase

    def test_redash_api_key_is_available
        value = ENV['REDASH_API_KEY']

        assert_not_nil(value)
    end

    def test_redash_base_url_is_available
        value = ENV['REDASH_BASE_URL']

        assert_not_nil(value)
    end

    def test_redash_is_available_via_http
        response = HTTParty.get("#{ENV['REDASH_BASE_URL']}/api/data_sources", {
            headers: {
                'Authorization' => "Key #{ENV['REDASH_API_KEY']}", 
                'Content-Type' => 'application/json'
            },
        })
        assert_equal(200, response.code)
    end
end