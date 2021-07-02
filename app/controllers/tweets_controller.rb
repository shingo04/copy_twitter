class TweetsController < ApplicationController
  def index
    @tweets = Tweet.includes(:user).order(id: "DESC").first(100)
    @tweet = Tweet.new
  end

  def create
    @tweets = Tweet.includes(:user).order(id: "DESC").first(100)
    @tweet = Tweet.create(tweet_params)
    if @tweet.save
      redirect_to root_path
    else
      render :index
    end
  end

  def show
    @tweet = Tweet.find(params[:id])
  end

  def seach
    @tweets = Tweet.search(params[:keyword])
  end

  private

  def tweet_params
    params.require(:tweet).permit(:text, :image).merge(user_id: current_user.id)
  end
end
