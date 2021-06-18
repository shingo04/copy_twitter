class TweetsController < ApplicationController
  def index
    @tweets = Tweet.includes(:user).order(id: "DESC").first(100)
    @tweet = Tweet.new
  end

  def create
    @tweet = Tweet.create(tweet_params)
    if @tweet.save
      redirect_to root_path
    else
      redirect_to new_user_registration_path
    end
  end

  private

  def tweet_params
    params.require(:tweet).permit(:text).merge(user_id: current_user.id)
  end
end
