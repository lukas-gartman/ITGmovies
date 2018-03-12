class Salon < QuickData
    table "salons", String
    primary_key "id", Integer, required: true
    column "capacity", String, required: true
    column "vip", Boolean, default: false, required: true
    column "handicap", Boolean, default: false, required: true

    attr_accessor :id, :capacity, :vip, :handicap

    def initialize(id, capacity, vip, handicap)
        @id = id
        @capacity = capacity
        @vip = vip
        @handicap = handicap
        yield(self) if block_given?
    end

    def self.create(capacity, vip, handicap)
        @@db.execute("INSERT INTO salons (capacity, vip, handicap) VALUES (?, ?, ?)", capacity, vip, handicap)
        result = @@db.execute("SELECT * FROM salons WHERE id = last_insert_rowid()").first
        return self.new(*result) unless result.nil?
    end

    def self.all
        salons = @@db.execute("SELECT * FROM salons")
        salon_objects = []
        for salon in salons
            salon_objects.push(self.new(*salon))
        end
        return salon_objects
    end

    def self.select(id)
        result = @@db.execute("SELECT * FROM salons WHERE id = ?", id).first
        return nil if result.nil?
        return self.new(*result)
    end
end