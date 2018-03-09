class App < Sinatra::Base
    
	enable :sessions
	register Sinatra::Flash
	# register Sinatra::Streaming

	helpers do
		def display(file)
			slim file
		end
	end

	not_found do
		status 404
		@title = "404 Not Found"
		slim :'utils/not_found'	
	end

	before do
		if session[:username]
			@user = Account.select(session[:username])
		end
	end
	
	get '/' do
		if session[:username]
			@title = "ITG Movies"
			@movies = Movie.all
			slim :index
		else
			@title = "ITG Movies | Sign in"
			slim :login
		end
    end
	
	get '/denied' do
		status 403
		@title = "Access denied"
		slim :denied
	end

	get '/register' do
		@title = "Register account"
		slim :register
	end

	post '/register' do
		username = params['username']
		password = params['password']
		password_repeat = params['password_repeat']
		email = params['email']
		Account.create(username, password, password_repeat, email)
		flash[:success] = "Account created. Welcome!"
		redirect back
	end

	get '/login' do

	end

	post '/login' do
		username = params['username']
		password = params['password']
		remember = params['remember']
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
		if session[:username]
			session.delete(:username)
			redirect back
		else
			flash[:error] = "You are not logged in"
			redirect back
		end
	end
	
	get '/test' do
		slim :test
	end

	get '/test/:username' do
		username = params[:username]
		@account = Account.select(username)
		slim :test
	end
end


