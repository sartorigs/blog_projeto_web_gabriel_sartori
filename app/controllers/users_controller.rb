class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to posts_path, notice: 'Usuário registrado e logado com sucesso!'

    else
      render :new
    end
  end

  def show
    @user = User.find_by(id: session[:user_id])
    if @user.nil?
      redirect_to login_path, alert: 'Usuário não encontrado.'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
