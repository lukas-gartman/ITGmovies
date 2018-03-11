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
        # args = method(__method__).parameters.map { |arg| arg[1].to_s }
        @@db.execute("INSERT INTO tickets (owner, show, seat) VALUES (?, ?, ?)", owner, show, seat)
        result = @@db.execute("SELECT * FROM tickets WHERE id = last_insert_rowid()").first
        return self.new(*result)
    end

    def self.get_tickets_for_show(show)
        tickets = @@db.execute("SELECT * FROM tickets WHERE show = ?", show)
        # return self.new(*tickets.first) if tickets.length == 1

        booked_tickets = []
        for ticket in tickets
            booked_tickets.push(self.new(*ticket))
        end
        return booked_tickets
    end

    def self.select(id)
        result = @@db.execute("SELECT * FROM tickets WHERE id = ?", id).first
        return nil if result.nil?
        return self.new(*result)
    end

    def self.all(options = {})
        #could add option to order by show, etc.
        tickets = @@db.execute("SELECT * FROM tickets")

        ticket_objects = []
        for ticket in tickets
            ticket_objects.push(self.new(*ticket))
        end

        return ticket_objects
    end
end