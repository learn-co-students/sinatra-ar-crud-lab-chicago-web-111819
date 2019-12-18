
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    set :method_override, true
  end

  get '/' do
    redirect to "/articles"
  end

  get '/articles' do
    @articles = Article.all
    erb:'index'
  end

  get '/articles/new' do
    erb:'new'
  end

  post '/articles' do
    # binding.pry
    @article = Article.create(title: params[:title], content: params[:content])
    redirect to "/articles/#{ @article.id }"
  end

  get '/articles/:id' do
    @article = Article.find_by(id: params[:id])
    erb:'show'
  end

  get '/articles/:id/edit' do
    @article = Article.find_by(id: params[:id])
    erb:'edit'
  end

  patch '/articles/:id' do
    @article = Article.find_by(id: params[:id])
    @article.update(title: params[:title], content: params[:content])
    redirect to "/articles/#{ @article.id }"
  end

  delete '/articles/:id' do
    @article = Article.find_by(id: params[:id])
    @article.delete
    redirect to "/articles"
  end

end