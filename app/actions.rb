require "net/http"
require "uri"

# Homepage (Root path)
get '/' do
  erb :index
end

get '/songs' do
  @songs = Song.all
  erb :'songs/index'
end

# get '/songs' do
#   erb :'songs/index'
# end

get '/songs/new' do
  @song = Song.new
  erb :'songs/new'
end

post '/songs' do
  @song = Song.new(
    name: params[:song],
    artist: params[:artist],
    genre: params[:genre],
    url: params[:url]
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


