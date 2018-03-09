class QuickData
    @@db = SQLite3::Database.open('db/database.sqlite')

    def self.table(name, options = {})
        @table = name
    end

    def self.primary_key(name, type, options = {})
        @id = name
    end

    def self.column(name, type, options = {})
        @columns ||= []
        @columns.push(name)
    end

    def self.encrypted(name, type, options = {})

    end
    
    def first

    end

end