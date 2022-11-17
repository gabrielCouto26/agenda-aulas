class AuthController < ApplicationController
  skip_before_action :verify_authenticity_token  

  def login
    email = auth_params[:email]
    password = auth_params[:password]
    user = User.where(email: email).first
    if user.present?
      correct_pass = user.password == password
      if correct_pass
        render json: { status: 204, data: { user_id: user.id } }
      else
        render json: { status: 401, data: "Senha incorreta" }
      end
    else
      render json: { status: 404, data: "Usuário não cadastrado" }
    end
  end

  private

  def auth_params
    params.require(:auth).permit(:email, :password, :profileType)
  end
end
