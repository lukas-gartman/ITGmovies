class Account

    db = SQLite3::Database.open('../db/database.sqlite')

    attr_accessor :username, :email, :pass_hash, :rank

    def initialize(username, email, pass_hash, rank)
        @username = username
        @pass_hash = pass_hash
        @email = email
        @rank = rank
    end
    
    # Instance methods
    def auth

    end

    def getRank(username)
        db.execute("SELECT rank FROM accounts WHERE username = ?", username)
    end
    
    def setRank(username, rank)
        db.execute("UPDATE accounts SET rank = ? WHERE username = ?", rank, username)
    end


    # Class methods
    def self.auth(username, password)
        username = username.downcase
        account = Account.get(username)
        if account.nil?
            return false
        else
            account_username = account[1]
            account_pass = account[2]
            encrypted_pass = BCrypt::Password.new(account_pass)
            if (account_username == username) && (encrypted_pass == password)
                return username
            else
                return false
            end
        end
    end
    
    def self.create(username, password, email)
        encrypted_pass = BCrypt::Password.create(password)
        if !/^[a-zA-Z0-9_]\w{2,15}$/.match(username)
            @error = "Username may only contain characters (A-Z), numbers (0-9), underscores and be 3-16 characters long."
            return false
        elsif !/\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i.match(email)
            @error = "Please enter a valid email address."
            return false
        elsif password.length < 6
            @error = "Password must be at least 6 characters long."
            return false
        else
            db.execute("INSERT INTO accounts (username, password, email) VALUES (?, ?, ?)", username, encrypted_pass, email)
            account = db.execute("SELECT last_insert_rowid() FROM accounts").first
            return account
        end
    end

    def self.remove(username)
        db.execute("DELETE FROM accounts WHERE username = ?", username)
    end

    def self.get(username)
        return db.execute("SELECT * FROM accounts WHERE username = ?", username).first
    end

    def self.find(username)
        return db.execute("SELECT * FROM accounts WHERE username LIKE ?", "%#{username}%")
    end

    def all
        accounts = db.execute("SELECT * FROM accounts")
        accounts.each do |account|
            Account.new(account[1], account[3], account[4], account[5], account[6])
        end
    end

    def first
        db.execute("SELECT * FROM accounts LIMIT 1")
    end

    def latest
        db.execute("SELECT * FROM accounts ORDER BY DESC LIMIT 1")
    end

end