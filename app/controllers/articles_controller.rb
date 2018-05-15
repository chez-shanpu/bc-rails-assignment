class ArticlesController < ApplicationController


  def index
    @articles = Article.all
  end

  def new
    @article = current_user.articles.build
  end

  def create
    @article = current_user.articles.build(article_params)
    if @article.save
      redirect_to root_url
    else
      redirect_to root_url
    end
  end

  def show
    @article = Article.find_by(params[:id])
  end

  def edit
    @artic
  end

  def update
    @article = Article.find_by(params[:id])
    if @article.update_attributes(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    @article = Article.find_by(params[:id])
    @article.destroy
    redirect_to root_url
  end

  private

  # strong params
  def article_params
    params.require(:article).permit(:title, :content)
  end

  def correct_user
    @article = Article.find_by(params[:id])
    redirect_to root_url unless current_user == @article.user
  end
end
