class RecipesController < ApplicationController
  before_action :authorize
rescue_from ActiveRecord::RecordInvalid, with: :render_record_invalid

  def index
      recipe = Recipe.all
      render json: recipe , status: :created
  end

  def create 
    user = User.find_by(id: session[:user_id])
    recipe = Recipe.create!(title: params[:title], instructions: params[:instructions], minutes_to_complete: params[:minutes_to_complete], user_id: user.id)
    render json: recipe, status: :created
    
  end
  
  private 
  def authorize
    return render json: {errors: ["Not authorized"]}, status: :unauthorized unless session.include? :user_id
end

  def render_record_invalid(e)
    render json: {errors: e.record.errors.full_messages}, status: :unprocessable_entity
  end


end
