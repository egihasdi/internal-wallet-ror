class ApplicationController < ActionController::API
  attr_reader :current_user

  private

  def authorize_request
    header = request.headers["Authorization"]
    token = header.split(" ").last if header
    decoded = JWT.decode(token, Rails.application.secret_key_base, true)
    payload = decoded[0]
    indifferent_payload = HashWithIndifferentAccess.new(payload)

    @current_user = User.find_by(id: indifferent_payload[:user_id]) if decoded

    render(json: {error: "Unauthorized"}, status: :unauthorized) unless @current_user
  rescue => e
    puts("error: #{e.message}")
    render(json: {error: "Invalid token"}, status: :unauthorized)
  end
end
