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

  def create; end
end
