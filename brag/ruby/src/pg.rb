require 'test/unit'
require 'pg'

class TddReadyTest < Test::Unit::TestCase

  def test_postgres_is_available
    
    PG.connect(
        host: 'host.docker.internal', 
        port: 2345,
        dbname: 'exploration', 
        user: 'dev', 
        password: 'dev'
    ) do |conn|
      conn.exec('SELECT 1 pong') do |result|
        assert_equal('1', result[0]['pong'])
      end
    end
  end
end