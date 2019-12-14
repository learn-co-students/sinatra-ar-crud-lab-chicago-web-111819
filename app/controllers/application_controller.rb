
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    set :method_override, true
  end

  # get '/' do
  #   "Nothing on the default home page..."
  # end

  get '/articles' do
    @articles = Article.all
    erb :index
  end

  get '/articles/new' do
    erb :new
  end

  post "/articles" do
    t = params[:title]
    c = params[:content]
    article = Article.create(title: t, content: c)
    redirect to("/articles/#{article.id}")
  end

  get '/articles/:id' do
    @article = find_a
    erb :show
  end

  get '/articles/:id/edit' do
    @article = find_a
    erb :edit
  end

  patch '/articles/:id' do
    article = find_a
    article.title = params[:title]
    article.content = params[:content]
    article.save
    redirect to("/articles/#{article.id}")
  end

  delete '/articles/:id' do
    @article = find_a
    @article.delete
    redirect to("/articles")
  end

  def find_a
    Article.find_by_id(params[:id])
  end

end
