class ChitterChallenge < Sinatra::Base

  get '/users/new' do
    @user = User.new
    erb :'users/sign_up'
  end

  post '/users' do
  @user = User.create(email: params[:email], name: params[:name], username: params[:username], password: params[:password], password_confirmation: params[:password_confirmation])
    if @user.save
      session[:user_id] = @user.id
      redirect '/peeps'
    else
      flash.now[:errors] = @user.errors.full_messages
      erb :'users/sign_up'
    end
  end
end
