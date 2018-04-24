class Ticket < QuickData
    table "tickets", String
    primary_key "id", Integer, required: true
    column "owner", String, required: true
    column "show", Integer, required: true
    column "seat", Integer, required: true

    attr_accessor :id, :owner, :show, :seat

    def initialize(id, owner, show, seat)
        @id = id
        @owner = owner
        @show = show
        @seat = seat
        yield(self) if block_given?
    end

    def self.create(owner, show, seat)
        if is_sqlite?
            @@db.execute("INSERT INTO tickets (owner, show, seat) VALUES (?, ?, ?)", owner, show, seat)
            result = @@db.execute("SELECT * FROM tickets WHERE id = last_insert_rowid()").first
            return self.new(*result)
        elsif is_mysql?
            query = @@db.prepare("INSERT INTO tickets (owner, show, seat) VALUES (?, ?, ?")
            query.execute(owner, show, seat)
            id = @@db.last_id
            result = @@db.execute("SELECT * FROM tickets WHERE id = #{id}").first
            return self.new(*result)
        end
    end

    def self.get_tickets_for_show(show)
        if is_sqlite?
            tickets = @@db.execute("SELECT * FROM tickets WHERE show = ?", show)
        elsif is_mysql?
            query = @@db.prepare("SELECT * FROM tickets WHERE show = ?")
            tickets = query.execute(show).first
        end

        booked_tickets = []
        for ticket in tickets
            booked_tickets.push(self.new(*ticket))
        end
        return booked_tickets
    end

    def self.select(id)
        if is_sqlite?
            result = @@db.execute("SELECT * FROM tickets WHERE id = ?", id).first
            return nil if result.nil?
            return self.new(*result)
        elsif is_mysql?
            query = @@db.prepare("SELECT * FROM tickets WHERE id = ?")
            result = query.execute(id).first
            return nil if result.nil?
            return self.new(*result)
        end
    end

    def self.all(options = {})
        #could add option to order by show, etc.
        # if is_sqlite?
            tickets = @@db.execute("SELECT * FROM tickets")
        # elsif is_mysql?
        #     tickets = @@db.execute("SELECT * FROM tickets", as: :array).to_a
        # end

        ticket_objects = []
        for ticket in tickets
            ticket_objects.push(self.new(*ticket))
        end

        return ticket_objects
    end
end