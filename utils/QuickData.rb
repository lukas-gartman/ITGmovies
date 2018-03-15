class QuickData
    def initialize
        
    end

    def self.setup(options)
        if options['adapter'] == "sqlite3"
            if options['path']
                @@db = SQLite3::Database.open(options['path'])
            else
                raise "No path was specified"
            end
        elsif options['adapter'] == "mysql2"
            if !options['host']
                raise "No host was specified"
            elsif !options['port']
                options['port'] = 3306
            elsif !options['database']
                raise "No database was specified"
            elsif !options['username']
                raise "No username was specified"
            elsif !options['password']
                raise "No password was specified"
            else
                @@db = Mysql2::Client.new(
                    :host => options['host'],
                    :port => options['port'],
                    :database => options['database'],
                    :username => options['username'],
                    :password => options['password']
                )
            end
        else
            raise "No adapter was specified"
        end
    end

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
end