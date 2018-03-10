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