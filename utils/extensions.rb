module Boolean; end
class TrueClass; include Boolean; end
class FalseClass; include Boolean; end

class Array
    def split(x)
        array = []
        i = 0
        while i < self.length
            array.push(self[i...i+x])
            i += x
        end
        return array
    end
end
