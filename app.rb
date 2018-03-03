class App < Sinatra::Base
    
	enable :sessions
	register Sinatra::Flash
	# register Sinatra::Streaming
	
	db = SQLite3::Database.open('db/database.sqlite')
	$user = false
	$admin = false
	
	helpers do
		def display(file)
			slim file
		end
	end
	
	get '/' do
		if session[:username]
			@title = "ITG Movies"
			slim :index
		else
			@title = "ITG Movies | Sign in"
			slim :login
		end
    end
	
	not_found do
		status 404
		slim :not_found
	end

	get '/not_found' do
		status 404
		@title = "Not found"
		slim :not_found
	end
	
	get '/denied' do
		status 403
		@title = "Access denied"
		slim :denied
	end
	
	get '/login' do
		if session[:username]
			# session[:flash] = ["You are already logged in", "alert-fail"]
			flash[:fail] = "You are already logged in"
			redirect '/'
		else
			@title = "Sign in"
			slim :login
		end
	end
	
	post '/login' do
		username = params['username'].downcase
		password = params['password']
		credentials = db.execute("SELECT username, pass_hash FROM accounts WHERE username = ?", username).first
		if credentials.nil?
			flash[:fail] = "Invalid username or password"
			redirect back
		else
			pass_hash = BCrypt::Password.new(credentials[1])
			if (credentials.first.downcase == username.downcase) && (pass_hash == password)
				session[:username] = username
				redirect '/'
			else
				# session[:flash] = ["Invalid username or password", "alert-fail"]
				flash[:fail] = "Invalid username or password"
				redirect back
			end
		end
	end
	
	get '/logout' do
		if session[:username]
			session.destroy
			$user = false
			$admin = false
			redirect '/'
		else
			# session[:flash] = ["You are not logged in", "alert-fail"]
			flash[:fail] = "You are not logged in"
			redirect back
		end
	end
	
	get '/register' do
		if session[:username]
			# session[:flash] = ["You are already logged in", "alert-fail"]
			flash[:fail] = "You are already logged in"
			redirect '/'
		else
			@title = "Register"
			#captcha was changed to instance var, might have to be global
			@captcha = [rand(1..100), rand(1..100)]
			slim :register
		end
	end
	
	post '/register' do
		username = params['username'].downcase
		password = params['password']
		email = params['email'].downcase
		# captcha = params['captcha'].to_i
		pass_hash = BCrypt::Password.create(password)
		# salt = pass_hash.salt
		# p $captcha[0] + $captcha[1]
		if !/^[a-zA-Z0-9_]\w{2,15}$/.match(username)
			flash[:fail] = "Username may only contain characters (A-Z), numbers (0-9), underscores and be 3-16 characters long."
			redirect back
		elsif !/\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i.match(email)
			flash[:fail] = "Please enter a valid email address."
			redirect back
		elsif password.length < 6
			flash[:fail] = "Password must be at least 6 characters long"
			redirect back
		# elsif captcha != ($captcha[0] + $captcha[1])
		# 	flash[:fail] = "Captcha was wrong"
		# 	redirect back
		else
			db.execute("INSERT INTO accounts (username, pass_hash, email) VALUES (?, ?, ?)", username, pass_hash, email)
			session[:username] = username
			flash[:success] = "Account registered. Welcome to ITG Movies!"
			redirect '/'
		end
	end
	
	get '/ucp' do
		if session[:username]
			@title = "UCP"
			@email = db.execute("SELECT email FROM accounts WHERE username = ?", session[:username]).first.first
			slim :ucp
		else
			redirect '/denied'
		end
	end
	
	post '/ucp/password' do
		if session[:username]
			old_pass = params['old_pass']
			new_pass = params['new_pass']
			db_pass = db.execute("SELECT pass_hash FROM accounts WHERE username = ?", session[:username]).first.first
			pass_hash = BCrypt::Password.new(db_pass)
			if pass_hash == old_pass
				if new_pass.length < 6
					# session[:flash] = ["New password must be at least 6 characters long", "alert-fail"]
					flash[:fail] = "New password must be at least 6 characters long."
					redirect '/ucp'
				else
					new_pass_hash = BCrypt::Password.create(new_pass)
					salt = new_pass_hash.salt
					db.execute("UPDATE accounts SET pass_hash = ?, salt = ? WHERE username = ?", new_pass_hash, salt, session[:username])
					# session[:flash] = ["Password updated successfully!", "alert-success"]
					flash[:success] = "Password updated successfully!"
					redirect '/ucp'
				end
			else
				# session[:flash] = ["Old password does not match", "alert-fail"]
				flash[:fail] = "Old password does not match."
				redirect '/ucp'
			end
		else
			redirect '/denied'
		end
	end
	
	post '/ucp/email' do
		if session[:username]
			email = params['email']
			db.execute("UPDATE accounts SET email = ? WHERE username = ?", email, session[:username])
			# session[:flash] = ["Email updated successfully!", "alert-success"]
			flash[:success] = "Email updated successfully!"
			redirect '/ucp'
		else
			redirect '/denied'
		end
	end
	
	get '/post/:id' do
		id = params['id']
		@post = db.execute("SELECT * FROM posts WHERE id = ?", id).first
		@user = session[:username]
		
		if @post[6] != ""
			uploads_id = @post[6]
			@file = db.execute("SELECT filename, identifier FROM uploads WHERE id = ?", uploads_id).first
		end
		
		if !@post
			redirect '/not_found'
		else
			slim :post
		end
	end
	
	get '/user/:username' do
		@username = params['username']
		@post_count = db.execute("SELECT COUNT(id) FROM posts WHERE author = ?", @username).first.first
		@email = db.execute("SELECT email FROM accounts WHERE username = ?", @username).first.first
		slim :user
	end
end


