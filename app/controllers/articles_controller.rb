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
    if article.valid?
      # we will figure that out
    else
      render json: article, adapter: :json_api,
             serializer: ActiveModel::Serializer::ErrorSerializer,
             status: :unprocessable_entity
    end
  end

  private

  def article_params
    ActionController::Parameters.new
  end
end
