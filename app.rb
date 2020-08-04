require './lib/listing.rb'
require 'sinatra/flash'
require 'sinatra/base'
require './database_connection_setup'
require './lib/user'
require './lib/picture'
require './lib/availability'
require './lib/booking'
require './lib/database_connection.rb'

class MakersBnB < Sinatra::Base
  enable :sessions, :method_override
  register Sinatra::Flash

  get '/' do
    @listings = Listing.all
    @user = User.find(id: session[:user_id])
    erb (:index)
  end

  get '/listings/new' do
    redirect '/' if User.current_user == nil
    erb (:'listings/new')
  end

  get '/listings/:id/show' do
    @listing = Listing.find(id: params[:id])
    @unicorn = @listing.available_dates
    @user = User.find(id: @listing.user_id)

    erb (:'listings/show')
  end

  post '/listings' do
    listing = Listing.create(name: params[:name], description: params[:description], price: params[:price])
    Picture.create(url: params[:picture_url], listing_id: listing.id)
    Available_Dates.create(listing_id: listing.id, date_start: params[:date_start], date_end: params[:date_end])
    flash[:notice] = "Your listing has been added"
    redirect '/'
  end

  get "/users/:username/user" do
    @user = User.current_user
    @listings = @user.listings
    session[:username] = @user.username
    erb (:'/users/user')
  end

  get "/listings/:id/edit" do
    @listing_id = params[:id]
    @listing = Listing.find(id: @listing_id)
    erb (:'listings/edit')
  end

  patch '/listings/:id' do
    listing = Listing.update(id: params[:id], name: params[:name], description: params[:description], price: params[:price])
    Picture.update(url: params[:url], listing_id: listing.id)
    redirect "/users/#{session[:username]}/user"
  end

  delete '/listings/:id' do
    Picture.delete(listing_id: params[:id])
    DatabaseConnection.query("DELETE FROM available_dates WHERE listing_id = #{params[:id]};")
    Listing.delete(id: params[:id])
    redirect "/users/#{session[:username]}/user"
  end

  get '/signup' do
    flash[:warning] = "this username/email already exists"
    erb (:signup)
  end

  post '/register' do
    begin
      user = User.create(email: params[:email], username: params[:username],
        password: params[:password])
    rescue PG::UniqueViolation
      redirect '/signup'
    end
    session[:user_id] = user.id
    flash[:welcome_user] = "Registration successful. Please sign in!"
    redirect '/'
  end

  get '/sessions/new' do
    erb (:'/sessions/new')
  end

  post '/sessions' do
    user = User.authenticate(username: params[:username], password: params[:password])

    if user
      session[:user_id] = user.id
      redirect '/'
    else
      flash[:notice] = 'Please check your username or password!'
      redirect '/sessions/new'
    end
  end

  post '/sessions/destroy' do
    session.clear
    User.sign_out
    flash[:notice] = 'You have signed out!'
    redirect '/'
  end


  get '/booking/:id/book' do
    @listing_id = params[:id]
    erb (:'booking/book')
  end

  post '/:id/store_booking' do
    listing_id = params[:id]
    Booking.create(listing_id: params[:id], user_id: User.current_user.id, book_from: params[:book_from], book_to: params[:book_to])
    redirect "/#{listing_id}/booking/confirmation"
  end

  get '/:id/booking/confirmation' do
    @listing_id = params[:id]
    @listing = Listing.find(id: params[:id])
    erb (:'/booking/confirmation')
  end

  run! if app_file == $0
end
