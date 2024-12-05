Rails.application.routes.draw do
  get("up" => "rails/health#show", :as => :rails_health_check)

  post("/auth/token", to: "auth#token")

  post("/wallets/deposit", to: "wallets#deposit")
  post("/wallets/withdraw", to: "wallets#withdraw")
  post("/wallets/transfer", to: "wallets#transfer")
  get("/wallets/balance", to: "wallets#balance")
end
