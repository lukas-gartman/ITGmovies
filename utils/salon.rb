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

    def self.select(id)
        result = @@db.execute("SELECT * FROM salons WHERE id = ?", id).first
        return nil if result.nil?
        return self.new(*result)
    end
end