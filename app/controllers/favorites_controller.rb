class FavoritesController < ApplicationController
  before_action :set_micropost

  def create
    @micropost = Micropost.find(params[:micropost_id])
    current_user.favorite(@micropost)
    #current_user.favorites.create(micropost_id: @micropost)
    #Favorite.create({user_id: current_user.id, micropost_id: @micropost.id})
  end

  def destroy
    @micropost = current_user.favorite_microposts.find(params[:micropost_id])
    current_user.unfavorite(@micropost)
    # current_user.favorites.micropost.where(micropost_id: @micropost.id).destroy_all
    #Fovorite.find_by(user_id: current_user.id, micropost_id: @micropost.id).destroy
  end

  private
  def set_micropost
    #@micropost = Micropost.find(params[:micropost_id])
  end
end
