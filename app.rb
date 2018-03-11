class App < Sinatra::Base
    
	enable :sessions
	register Sinatra::Flash
	# register Sinatra::Streaming

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
		slim :denied
	end
	
	get '/' do
		if logged_in?
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
		order = params[:order]

		movies = Movie.all(order: order).split(15)
		@page_count = movies.length
		@movies = movies[@current_page - 1]
		if @movies.nil?
			flash[:error] = "Page does not exist"
			redirect back
		end
		slim :index
	end

	get '/register' do
		if logged_in?
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
		redirect back
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
			session.options[:expire_after] = 2592000 unless remember.nil?
			flash[:success] = "Logged in"
			redirect back
		else
			flash[:error] = "Invalid username or password"
			redirect back
		end
	end

	get '/logout' do
		if logged_in?
			session.delete(:username)
			redirect '/'
		else
			flash[:error] = "You are not logged in"
			redirect back
		end
	end

	get '/movie/:id' do
		id = params[:id]
		salon = params[:salon]
		@movie = Movie.select(id)
		# @ip_status = Account.is_vip?

		@shows = Show.get_shows_for_movie(id)
		unless @shows.empty?
			# for show in @shows
			# 	salon_capacity = Salon.select(show.salon).capacity.split("x")
			# 	tickets = Ticket.get_tickets_for_show(show.id)
			# end

			salon_capacity = Salon.select(@shows.first.salon).capacity.split("x")
			tickets = Ticket.get_tickets_for_show(@shows.first.id)

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
		
		if logged_in?
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
	
	get '/test' do
		
	end

	get '/test/:username' do
		username = params[:username]
		@account = Account.select(username)
		slim :test
	end
end


