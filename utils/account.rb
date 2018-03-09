class Account < QuickData
    #config
    table "accounts", String
    primary_key "id", Integer, required: true
    column "username", String, required: true
    encrypted "pass_hash", String, required: true
    column "email", String, required: true
    column "rank", Integer, default: 0
    column "last_active", DateTime, default: DateTime.now
    column "registration_date", DateTime, default: DateTime.now

    attr_accessor :id, :username, :pass_hash, :email, :rank, :last_active

    def initialize(id, username, pass_hash, email, rank, register_date, last_active)
        @username = username
        @pass_hash = pass_hash
        @email = email
        @rank = rank
        @register_date = register_date
        @last_active = last_active
        yield(self) if block_given?
    end

    def to_a
        ivars = self.instance_variables
        values = []
        for var in ivars
            values.push(self.instance_variable_get(var))
        end
        return values
    end

    def each
        ivars = self.instance_variables
        values = []
        for var in ivars
            values.push yield self.instance_variable_get(var) if block_given?
        end
        return values
    end

    def each_with_index
        ivars = self.instance_variables
        values = []
        index = 0
        for var in ivars
            values.push yield self.instance_variable_get(var), index if block_given?
            index += 1
        end
        return values, index
    end

    def self.create(username, password, password_repeat, email)
        raise "Password mismatch" unless password == password_repeat
        pass_hash = BCrypt::Password.create(password)
        @@db.execute("INSERT INTO accounts (username, pass_hash, email) VALUES (?, ?, ?)", username, pass_hash, email)
        result = @@db.execute("SELECT * FROM accounts WHERE id = last_insert_rowid()").first
        return self.new(*result)
    end

    def self.remove(username)
        return @@db.execute("DELETE FROM accounts WHERE username = ?", username)
    end

    def self.auth(username, password)
        user = self.select(username)
        return false if user.nil?
        db_password = BCrypt::Password.new(user.pass_hash)
        if db_password == password
            return user
        else
            return false
        end
    end

    def self.select(username)
        result = @@db.execute("SELECT * FROM accounts WHERE username = ?", username).first
        return nil if result.nil?
        return self.new(*result)
    end

    def self.all
        accounts = @@db.execute("SELECT * FROM accounts")
        account_objects = []
        for account in accounts
            account_objects.push(self.new(*account))
        end
        return account_objects
    end

    def self.first
        begin
            return @@db.execute("SELECT * FROM accounts LIMIT 1").first
        rescue
            raise "Table is empty"
        end
    end

    def self.set_rank(username, rank)
        return @@db.execute("UPDATE accounts SET rank = ? WHERE username = ?", rank, username)
    end
end