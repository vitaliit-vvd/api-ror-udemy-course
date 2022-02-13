# frozen_string_literal: true

class ArticlesController < ApplicationController
  skip_before_action :authorize!, only: %i[index show]

  def index
    articles = Article.recent
                      .page(params[:page])
                      .per(params[:per_page])
    render json: articles
  end

  def show; end

  def create
    article = Article.new(article_params)
    article.save!
    render json: article, status: :created
  rescue StandardError
    render json: article, adapter: :json_api,
           serializer: ErrorSerializer,
           status: :unprocessable_entity
  end

  def update
    article = Article.find(params[:id])
    article.update!(article_params)
    render json: article, status: :ok
  rescue StandardError
    render json: article, adapter: :json_api,
           serializer: ErrorSerializer,
           status: :unprocessable_entity
  end

  private

  def article_params
    params.require(:data).require(:attributes).permit(:title, :content, :slug) || ActionController::Parameters.new
  end
end
