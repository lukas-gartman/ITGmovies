class App < Sinatra::Base

	enable :sessions
	register Sinatra::Flash

	TIME_UNTIL_EXPIRE = 2592000

	helpers do
		def display(file)
			slim file
		end

		def logged_in?
			return true if session[:username]
		end

		def generate_seats(x, y)
			seats = []
			i = 1
			while i <= x*y
				seats.push((i...i+x).to_a)
				i += x
			end
			return seats
		end
	end

	before do
		if logged_in?
			@user = Account.select(session[:username])
		end
	end

	not_found do
		status 404
		@title = "404 Not Found"
		slim :'utils/not_found'	
	end

	get '/denied' do
		status 403
		@title = "Access denied"
		slim :'utils/denied'
	end


	get '/register' do
		if @user
			flash[:error] = "You already have an account"
			redirect back
		else
			@title = "Register account"
			slim :register
		end
	end

	post '/register' do
		username = params[:username]
		password = params[:password]
		password_repeat = params[:password_repeat]
		email = params[:email]
		Account.create(username, password, password_repeat, email)
		flash[:success] = "Account created. Welcome!"
		redirect '/'
	end

	get '/login' do
		slim :login
	end

	post '/login' do
		username = params[:username]
		password = params[:password]
		remember = params[:remember]

		if Account.auth(username, password)
			session[:username] = username
			session.options[:expire_after] = TIME_UNTIL_EXPIRE unless remember.nil?
			redirect '/'
		else
			flash[:error] = "Invalid username or password"
			redirect back
		end
	end

	get '/logout' do
		if @user
			session.destroy
			redirect '/'
		else
			flash[:error] = "You are not logged in"
			redirect back
		end
	end

	get '/admin' do
		if !@user.nil? && @user.rank == 3
			@movies = Movie.all(order: "asc")
			@salons = Salon.all
			slim :admin
		else
			# flash[:error] = "You do not have permission to view this page"
			@title = "Access denied"
			slim :'utils/denied'
		end
	end

	post '/show/create' do
		movie = params[:movie]
		salon = params[:salon]
		date = params[:date]
		time = params[:time]
		air_date = "#{date} #{time}:00"

		errors = []
		errors.push("Please select a movie") if movie.empty?
		errors.push("Please select a salon") if salon.empty?
		errors.push("Please select a date") if date.empty?
		errors.push("Please select a time") if time.empty?
		unless errors.empty?
			flash[:error] = errors
			redirect back
		end

		Show.create(movie, salon, air_date)
		flash[:success] = "Show has been created"
		redirect back
	end

	post '/salon/create' do
		capacity_x = params[:capacity_x]
		capacity_y = params[:capacity_y]
		capacity = "#{capacity_x}x#{capacity_y}"
		vip = params[:vip]
		handicap = params[:handicap]

		Salon.create(capacity, vip, handicap)
		flash[:success] = "Salon has been added"
		redirect back
	end

	post '/movie/create' do
		title = params[:title]
		description = params[:description]
		director = params[:director]
		genre = params[:genre]
		rating = params[:rating]
		year = params[:year]
		length = (params[:length_hours].to_i*60) + params[:length_minutes].to_i

		Movie.create(title, description, director, length, rating, year, genre)
		flash[:success] = "Movie has been added"
		redirect back
	end


	get '/' do
		if @user
			@title = "ITG Movies"
			@movies = Movie.all
			if @movies.length > 10
				redirect '/page/1'
			end
			slim :index
		else
			@title = "ITG Movies | Sign in"
			slim :login
		end
	end
	
	get '/page/:page' do
		@current_page = params[:page].to_i
		available = params[:available]
		order = params[:order]

		if available
			movies = Movie.all(order: order)

			available_shows = []
			for movie in movies
				show = Show.get_shows_for_movie(movie.id)
				unless show.empty?
					available_shows.push(movie)
				end
			end
			available_shows = available_shows.split(15)
			
			@page_count = available_shows.length
			@movies = available_shows[@current_page - 1]
			if @movies.nil?
				flash[:error] = "Page does not exist"
				redirect back
			end
		else
			movies = Movie.all(order: order).split(15)
			@page_count = movies.length
			@movies = movies[@current_page - 1]
			if @movies.nil?
				flash[:error] = "Page does not exist"
				redirect '/page/1'
			end
		end
		slim :index
	end

	get '/movie/:id' do
		id = params[:id]
		salon = params[:salon]
		@show_id = (params[:show].to_i) - 1 unless params[:show].nil?
		@show_id = 0 if params[:show].nil?
		@movie = Movie.select(id)

		@shows = Show.get_shows_for_movie(id)
		unless @shows.empty?
			salon_capacity = Salon.select(@shows[@show_id].salon).capacity.split("x")
			tickets = Ticket.get_tickets_for_show(@shows[@show_id].id)

			x = salon_capacity[0].to_i
			y = salon_capacity[1].to_i
			@seats = generate_seats(x, y)

			@seats_taken = []
			for ticket in tickets
				@seats_taken.push(ticket.seat)
			end
		end

		slim :movie
	end

	post '/movie/purchase' do
		movie_id = params[:id]
		show = params[:show]
		seats = params[:seat]
		
		if @user
			if seats.nil?
				flash[:error] = "You must select a seat"
				redirect back
			else
				seats.each do |_, seat|
					seat = seat.to_i
					Ticket.create(@user.username, show, seat)
				end

				flash[:success] = "Tickets have been purchased"
				redirect back
			end
		else
			# flash[:error] = "You must login before purchasing tickets"
			redirect '/'
		end
	end
end
