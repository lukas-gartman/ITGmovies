class Test
    attr_reader :id, :name
    attr_writer :name
    def initialize(id, name)
        @id = id
        @name = name
    end

    def self.lol(*lmao)
        # begin
            db = SQLite3::Database.open('../db/database.sqlite')
            arra = []
            lmao.each do |z|
                puts z
                arra.push(z)
            end
            return arra
        # rescue
        #     puts "Could not connect to DB"
        # end
    end

end

hehe = Test.new(1337, "lol")
puts Test.lol