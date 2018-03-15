module Boolean; end
class TrueClass; include Boolean; end
class FalseClass; include Boolean; end

module Mysql2
    class Client
        alias execute query
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
