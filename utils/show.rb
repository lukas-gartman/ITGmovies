class Show < QuickData
    table "shows", String
    primary_key "id", Integer, required: true
    column "movie", Integer, required: true
    column "salon", Integer, required: true
    column "air_date", DateTime, required: true

    attr_accessor :id, :movie, :salon, :air_date

    def initialize(id, movie, salon, air_date)
        @id = id
        @movie = movie
        @salon = salon
        @air_date = air_date
        yield(self) if block_given?
    end

    # def self.create(movie, salon, air_date)
    #     if is_sqlite?
    #         @@db.execute("INSERT INTO shows (movie, salon, air_date) VALUES (?, ?, ?)", movie, salon, air_date)
    #         result = @@db.execute("SELECT * FROM shows WHERE id = last_insert_rowid()").first
    #         return self.new(*result) unless result.nil?
    #     elsif is_mysql?
    #         query = @@db.prepare("INSERT INTO shows (movie, salon, air_date), VALUES (?, ?, ?)")
    #         query.execute(movie, salon, air_date)
    #         id = @@db.last_id
    #         result = @@db.execute("SELECT * FROM shows WHERE id = #{id}").first
    #         return self.new(*result) unless result.nil?
    #     end
    # end

    def self.get_shows_for_movie(id)
        if is_sqlite?
            shows = @@db.execute("SELECT * FROM shows WHERE movie = ?", id)
        elsif is_mysql?
            query = @@db.prepare("SELECT * FROM shows WHERE movie = ?")
            shows = query.execute(id)
        end

        movie_shows = []
        for show in shows
            movie_shows.push(self.new(*show))
        end
        return movie_shows
    end

    def self.all(options = {})
        # if is_sqlite?
            shows = @@db.execute("SELECT * FROM shows")
        # elsif is_mysql?
        #     shows = @@db.execute("SELECT * FROM shows", as: :array).to_a
        # end

        show_objects = []
        for show in shows
            show_objects.push(self.new(*show))
        end
    end
end