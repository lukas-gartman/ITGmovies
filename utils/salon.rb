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
        if is_sqlite?
            @@db.execute("INSERT INTO salons (capacity, vip, handicap) VALUES (?, ?, ?)", capacity, vip, handicap)
            result = @@db.execute("SELECT * FROM salons WHERE id = last_insert_rowid()").first
            return self.new(*result) unless result.nil?
        elsif is_mysql?
            query = @@db.prepare("INSERT INTO salons (capacity, vip, handicap) VALUES (?, ?, ?)")
            query.execute(capacity, vip, handicap)
            id = @@db.last_id
            result = @@db.execute("SELECT * FROM salons WHERE id = #{id}").first
            return self.new(*result) unless result.nil?
        end
    end

    def self.all
        if is_sqlite?
            salons = @@db.execute("SELECT * FROM salons")
        elsif is_mysql?
            salons = @@db.execute("SELECT * FROM salons", as: :array).to_a
        end

        salon_objects = []
        for salon in salons
            salon_objects.push(self.new(*salon))
        end
        return salon_objects
    end

    def self.select(id)
        if is_sqlite?
            result = @@db.execute("SELECT * FROM salons WHERE id = ?", id).first
            # return nil if result.nil?
            return self.new(*result)
        elsif is_mysql?
            query = @@db.prepare("SELECT * FROM salons WHERE id = ?")
            result = query.execute(id).first
            p result
            return self.new(*result)
        end
    end
end