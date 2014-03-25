require "net/http"
require "uri"
require 'bcrypt'

# Homepage (Root path)

helpers do
   # Usable in ERB templates everywhere, and in any action below
  def current_user
     @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end

get '/' do
  erb :index
end

get '/songs' do
  @songs = Song.all
  erb :'songs/index'
end

get '/songs/new' do
  @song = Song.new
  erb :'songs/new'
end

post '/songs' do
  @song = Song.new(
    name: params[:song],
    artist: params[:artist],
    genre: params[:genre],
    url: params[:url],
    user_id: session[:user_id]
  )
  if @song.save
    redirect '/songs'
  else
    erb :'/songs/new'
  end
end

get '/songs/:id' do
  @song = Song.find params[:id]
  erb :'songs/show'
end

### AUTHENTICATION ACTIONS

#Form
get "/signup" do
  erb :'auth/signup'
end

#Form
get "/login" do
  erb :'auth/login'
end

#Post signup
post "/signup" do
  @user = User.new(
    email: params[:email],
    password: params[:password]
  )

  if @user.save
    session[:user_id] = @user.id
    redirect '/'
  else
    erb :'auth/signup'
  end
end

#Post login
post "/login" do
  @user = User.find_by(email: params[:email])

  if @user.password == params[:password]
    # give_token
    session[:user_id] = @user.id
    redirect '/'
  else
    erb :'auth/login'
  end
end

#Post logout
post "/logout" do
  session[:user_id] = nil
  redirect '/'
end

#Post like
post "/songs/like/:song_id" do
  upvote = Upvote.create(
    song_id: params[:song_id],
    user_id: session[:user_id]
  )

  like = Song.find(params[:song_id]).vote_count
  like += 1
  Song.find(params[:song_id]).update(:vote_count => like)

  redirect "/songs"
end

#Post unlike
post "/songs/unlike/:song_id" do
  downvote = Upvote.find_by(
    song_id: params[:song_id],
    user_id: session[:user_id]
  ).id

  Upvote.delete(downvote)

  unlike = Song.find(params[:song_id]).vote_count
  unlike -= 1
  Song.find(params[:song_id]).update(:vote_count => unlike)

  redirect "/songs"
end

 


### YOUTUBE VALIDATOR

def youtube_embed(youtube_url)
  if youtube_url["<%= song.url %>"]
      youtube_id = $1
  else
      # Regex from # http://stackoverflow.com/questions/3452546/javascript-regex-how-to-get-youtube-video-id-from-url/4811367#4811367
      youtube_url[/^.*((v\/)|(embed\/)|(watch\?))\??v?=?([^\&\?]*).*/]
      youtube_id = $5
  end

  %Q{<iframe title="YouTube video player" width="640" height="390" src="http://www.youtube.com/embed/#{ youtube_id }" frameborder="0" allowfullscreen></iframe>}
end 

# def validate_id(youtube_id)
#   uri = URI.parse("http://gdata.youtube.com/feeds/api/videos/#{ youtube_id }")
#   http = Net::HTTP.new(uri.host, uri.port)
#   request = Net::HTTP::Get.new(uri.request_uri)
#   response = http.request(request)
#   %Q{ #{response.code} }
# end

# def youtube_data(youtube_id) 
#   if validate_id(youtube_id) == "200"
#     #video is good code
#   else %Q{ Video is no longer valid }
#   end
# end


