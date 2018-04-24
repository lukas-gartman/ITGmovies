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

    def self.logged_in?
        return true if session[:username]
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
        if is_sqlite?
            @@db.execute("INSERT INTO accounts (username, pass_hash, email) VALUES (?, ?, ?)", username, pass_hash, email)
            result = @@db.execute("SELECT * FROM accounts WHERE id = last_insert_rowid()").first
            return self.new(*result)
        elsif is_mysql?
            query = @@db.prepare("INSERT INTO accounts (username, pass_hash, email) VALUES (?, ?, ?)")
            query.execute(username, pass_hash, email)
            id = @@db.last_id
            # result = @@db.execute("SELECT * FROM accounts WHERE id = #{id}", as: :array).to_a
            result = @@db.execute("SELECT * FROM accounts WHERE id = #{id}").first
            return self.new(*result.values)
        end
    end

    def self.remove(username)
        if is_sqlite?
            return @@db.execute("DELETE FROM accounts WHERE username = ?", username)
        elsif is_mysql?
            query = @@db.prepare("DELETE FROM accounts WHERE username = ?")
            return query.execute(username)
        end
    end

    def self.auth(username, password)
        user = self.select(username)
        return false if user.nil?
        db_password = BCrypt::Password.new(user.pass_hash)
        db_password == password ? user : false
    end

    def self.select(username)
        if is_sqlite?
            result = @@db.execute("SELECT * FROM accounts WHERE username = ?", username).first
            return nil if result.nil?
            return self.new(*result)
        elsif is_mysql?
            query = @@db.prepare("SELECT * FROM accounts WHERE username = ?")
            result = query.execute(username).first
            p result
            
            return self.new(*result)
        end
    end

    def self.all
        if is_sqlite?
            accounts = @@db.execute("SELECT * FROM accounts")
        elsif is_mysql?
            accounts = @@db.query("SELECT * FROM accounts", as: :array).to_a
            # sql = @@db.query("SELECT * FROM accounts")
            # accounts = []
            # for account in sql
            #     accounts.push(account.values)
            # end
        end

        account_objects = []
        for account in accounts
            account_objects.push(self.new(*account))
        end
        return account_objects
    end

    def self.first
        begin
            if is_sqlite?
                account = @@db.execute("SELECT * FROM accounts LIMIT 1").first
                return self.new(*account)
            elsif is_mysql?
                account = @@db.execute("SELECT * FROM accounts LIMIT 1", as: :array).to_a.first
                return self.new(*account)
            end
        rescue
            raise "Table is empty"
        end
    end

    def self.set_rank(username, rank)
        if is_sqlite?
            return @@db.execute("UPDATE accounts SET rank = ? WHERE username = ?", rank, username)
        elsif is_mysql?
            query = @@db.prepare("UPDATE accounts SET rank = ? WHERE username = ?")
            return query.execute(rank, username)
        end
    end
end