class SessionsController < ApplicationController

  def create
    user = User.find_by(username: params[:username])
   if user&.authenticate(params[:password])
    session[:user_id] = user.id
    render json: user, status: :ok
   else
    render json: {errors: ["Invalid username or password"]}, status: :unauthorized
   end
   
   end
  # rescue ActiveRecord::RecordInvalid => e
    

def destroy
  return render json: {errors: ["Not authorized"]}, status: :unauthorized unless session.include? :user_id
  session.delete :user_id
  render json: {}, status: :no_content
end
end 
