class Movie < QuickData
    table "movies", String
    primary_key "id", Integer, required: true
    column "title", String, required: true
    column "description", String
    column "director", String
    column "length", Integer, default: 0
    column "rating", Integer
    column "year", Integer
    column "genre", String

    attr_accessor :id, :title, :description, :director, :length, :rating, :year, :genre

    def initialize(id, title, description, director, length, rating, year, genre)
        @id = id
        @title = title
        @description = description
        @director = director
        @length = length
        @rating = rating
        @year = year
        @genre = genre
        yield(self) if block_given?
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

    def self.create(title, description, director, length, rating, year, genre)
        @@db.execute("INSERT INTO movies (title, description, director, length, rating, year, genre) VALUES (?, ?, ?, ?, ?, ?, ?)", title, description, director, length, rating, year, genre)
        result = @@db.execute("SELECT * FROM movies WHERE id = last_insert_rowid()").first
        return self.new(*result)
    end

    def self.remove(title)
        @@db.execute("DELETE FROM movies WHERE username = ?", username)
    end

    def self.select(id)
        movie = @@db.execute("SELECT * FROM movies WHERE id = ?", id).first
        return self.new(*movie) unless movie.nil?
    end

    def self.search(title)
        result = @@db.execute("SELECT * FROM movies WHERE username LIKE ?", "%#{title}%").first
        return self.new(*result)
    end

    def self.all(options = {})
        if options[:order] == "rating"
            movies = @@db.execute("SELECT * FROM movies ORDER BY rating DESC")
        elsif options[:order] == "year"
            movies = @@db.execute("SELECT * FROM movies ORDER BY year DESC")
        elsif options[:order] == "asc"
            movies = @@db.execute("SELECT * FROM movies ORDER BY title ASC")
        elsif options[:order] == "desc"
            movies = @@db.execute("SELECT * FROM movies ORDER BY title DESC")
        else
            movies = @@db.execute("SELECT * FROM movies")
        end

        movie_objects = []
        for movie in movies
            movie_objects.push(self.new(*movie))
        end

        return movie_objects
    end

    def self.first
        begin
            return @@db.execute("SELECT * FROM movies LIMIT 1").first
        rescue
            raise "Table is empty"
        end
    end
end