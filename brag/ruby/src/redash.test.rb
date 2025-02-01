require 'test/unit'
require 'pg'
require 'httparty'

require './src/redash'

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
        assert_equal(1, Redash.new.get_data_source_id)
    end
end
