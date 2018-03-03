class Account < QuickData

    serial "id"
    tablename "accounts"

    # db = SQLite3::Database.open('db/database.sqlite')

    # def initialize(username, email, rank, profile_picture, last_active)
    #     @username = username
    #     @email = email
    #     @rank = rank
    #     @profile_picture = profile_picture
    #     @last_active = last_active
    # end

    # def self.create(username, password, email)
    #     db.execute("INSERT INTO accounts (username, password, email) VALUES (?, ?, ?)", username, password, email)
    # end

    # def self.remove(username)
    #     db.execute("DELETE FROM accounts WHERE username = ?", username)
    # end

    # def self.select(username)
    #     db.execute("SELECT * FROM accounts WHERE username = ?", username)
    # end

    # def self.all
    #     accounts = db.execute("SELECT * FROM accounts")
    #     accounts.each do |account|
    #         Account.new(account[1], account[3], account[4], account[5], account[6])
    #     end
    # end

    # def self.first
    #     db.execute("SELECT * FROM accounts LIMIT 1")
    # end

    # def self.set_rank(username, rank)
    #     db.execute("UPDATE accounts SET rank = ? WHERE username = ?", rank, username)
    # end
end