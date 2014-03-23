# Homepage (Root path)
get '/' do
  erb :index
end

get '/songs' do
  @songs = Song.all
  erb :'songs/index'
end

get '/songs' do
  erb :'songs/index'
end

get '/songs/new' do
  erb :'songs/new'
end