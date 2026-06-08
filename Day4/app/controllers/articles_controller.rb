class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_article, only: [:show, :edit, :update, :destroy, :report]
  before_action :authorize_user!, only: [:edit, :update, :destroy]

  def index
    @articles = Article.where(archived: false)
  end

  def show; end

  def new
    @article = current_user.articles.build
  end

  def create
    @article = current_user.articles.build(article_params)

    if @article.save
      redirect_to @article
    else
      render :new
    end
  end

  def edit; end

  def update
    if @article.update(article_params)
      redirect_to @article
    else
      render :edit
    end
  end

  def destroy
    @article.destroy
    redirect_to articles_path
  end

  def report
    @article.increment!(:reports_count)

    if @article.reports_count >= 3
      @article.update(archived: true)
    end

    redirect_to articles_path
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def authorize_user!
    redirect_to root_path unless @article.user == current_user
  end

  def article_params
    params.require(:article).permit(:title, :content, :image)
  end
end