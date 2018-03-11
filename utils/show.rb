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

    def self.get_shows_for_movie(id)
        shows = @@db.execute("SELECT * FROM shows WHERE movie = ?", id)

        movie_shows = []
        for show in shows
            movie_shows.push(self.new(*show))
        end
        return movie_shows
    end

    def self.all(options = {})
        shows = @@db.execute("SELECT * FROM shows")

        show_objects = []
        for show in shows
            show_objects.push(self.new(*show))
        end
    end
end