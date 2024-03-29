class QuickData
    def initialize
        
    end

    def self.establish_connection(options)
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

    def self.is_sqlite?
        if Sinatra::Base.development?
            if $config['development']['database']['adapter'] == "sqlite3"
                return true
            else
                return false
            end
        elsif Sinatra::Base.production?
            if $config['production']['database']['adapter'] == "sqlite3"
                return true
            else
                return false
            end
        end
    end

    def self.is_mysql?
        if Sinatra::Base.development?
            if $config['development']['database']['adapter'] == "mysql2"
                return true
            else
                return false
            end
        elsif Sinatra::Base.production?
            if $config['production']['database']['adapter'] == "mysql2"
                return true
            else
                return false
            end
        end
    end

    def self.table(name, options = {})
        @table = name
    end

    def self.primary_key(name, type, options = {})
        @primary_key = name
    end

    def self.column(name, type, options = {})
        # @columns ||= []
        # @columns.push([name, options])
        @columns ||= {}
        @columns[name] = {type: type, options: options}
    end

    def self.create(hash)
        hash.delete("captures")

        columns = hash.keys.join(", ")
        for column in hash.keys
            unless @columns.keys.include?(column)
                hash.delete(column)
            end
        end
        values = hash.values.join("', '")
        @@db.execute("INSERT INTO #{@table} (#{columns}) VALUES ('#{values}')")
    end

    def self.remove(hash)
        hash.delete("captures")
        columns = hash.keys.join(", = ?")
        for column in hash.keys
            unless @columns.keys.include?(column)
                hash.delete(column)
            end
        end
        values = hash.values.join(", ")
        escaperz = []
        columns.length.times { escaperz << '?' }
        escaperz.join(", ")
        @@db.execute("DELETE FROM #{@table} WHERE #{columns} = ?", values)
    end
end