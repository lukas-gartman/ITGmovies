module Boolean; end
class TrueClass; include Boolean; end
class FalseClass; include Boolean; end

module Mysql2
    class Result
        attr_reader :server_flags
        # include Enumerable
    end

    class Client
        alias execute query

        def self.default_query_options
            @default_query_options ||= {
              :as => :array,                  # the type of object you want each row back as; also supports :array (an array of values)
              :async => false,                # don't wait for a result after sending the query, you'll have to monitor the socket yourself then eventually call Mysql2::Client#async_result
              :cast_booleans => false,        # cast tinyint(1) fields as true/false in ruby
              :symbolize_keys => false,       # return field names as symbols instead of strings
              :database_timezone => :local,   # timezone Mysql2 will assume datetime objects are stored in
              :application_timezone => nil,   # timezone Mysql2 will convert to before handing the object back to the caller
              :cache_rows => true,            # tells Mysql2 to use its internal row cache for results
              :connect_flags => REMEMBER_OPTIONS | LONG_PASSWORD | LONG_FLAG | TRANSACTIONS | PROTOCOL_41 | SECURE_CONNECTION,
              :cast => true,
              :default_file => nil,
              :default_group => nil,
            }
        end

        
    end
end

class Array
    def split(n)
        array = []
        i = 0
        while i < self.length
            array.push(self[i...i+n])
            i += n
        end
        return array
    end
end

class String
    def true?
        self.to_s == "true"
    end
end
