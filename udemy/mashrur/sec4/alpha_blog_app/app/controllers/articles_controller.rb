class ArticlesController < ApplicationController
  before_action :get_article, only: [:show, :edit, :update, :destroy]
  
  def index 
    @articles = Article.all
  end

  def show
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(permit_params)
    if @article.save
      flash[:notice] = "Article saved successfully"
      redirect_to article_path(@article.id) 
    else
      render 'new'
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(permit_params)
      flash[:notice] = "Article updated successfully"
      redirect_to article_path(@article.id)
    else
      render 'edit'
    end
  end

  def destroy 
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to articles_path
  end

  private

  def get_article
    @article = Article.find(params[:id])
  end

  def permit_params
    params.require(:article).permit(:title, :description)
  end
end
