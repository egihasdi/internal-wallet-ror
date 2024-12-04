class AuthController < ApplicationController
  def token
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      # Generate a JWT token for the authenticated user
      token = user.generate_jwt
      render(json: {token: token}, status: :ok)
    else
      render(json: {error: "Invalid email or password"}, status: :unauthorized)
    end
  end
end
