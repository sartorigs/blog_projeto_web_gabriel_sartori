class SessionsController < ApplicationController
  def new
    if session[:user_id]
      redirect_to new_post_path 
    end
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to posts_path, notice: 'Login realizado com sucesso!'
    else
      flash.now[:alert] = 'Email ou senha inválidos'
      render 'new'
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to login_path, notice: 'Você saiu com sucesso.'
  end
end
