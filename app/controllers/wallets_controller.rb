class WalletsController < ApplicationController
  before_action :authorize_request
  before_action :set_wallet, only: [:deposit, :withdraw, :transfer, :balance]

  # POST /wallets/deposit
  def deposit
    amount = params[:amount].to_f
    if amount <= 0
      render(json: {error: "Amount must be greater than zero"}, status: :unprocessable_entity)
      return
    end

    transaction = CreditTransaction.new(
      target_wallet: @wallet,
      amount: amount
    )

    if transaction.apply
      render(json: {message: "Deposit successful", balance: @wallet.balance}, status: :ok)
    else
      render(json: {error: transaction.errors.full_messages}, status: :unprocessable_entity)
    end
  end

  # POST /wallets/withdraw
  def withdraw
    amount = params[:amount].to_f
    if amount <= 0
      render(json: {error: "Amount must be greater than zero"}, status: :unprocessable_entity)
      return
    end

    transaction = DebitTransaction.new(
      source_wallet: @wallet,
      amount: amount
    )

    if transaction.apply
      render(json: {message: "Withdrawal successful", balance: @wallet.balance}, status: :ok)
    else
      render(json: {error: transaction.errors.full_messages}, status: :unprocessable_entity)
    end
  end

  # POST /wallets/transfer
  def transfer
    target_wallet = Wallet.find_by(id: params[:target_wallet_id])
    amount = params[:amount].to_f

    if target_wallet.nil?
      render(json: {error: "Target wallet not found"}, status: :not_found)
      return
    end

    if amount <= 0
      render(json: {error: "Amount must be greater than zero"}, status: :unprocessable_entity)
      return
    end

    transaction = TransferTransaction.new(
      source_wallet: @wallet,
      target_wallet: target_wallet,
      amount: amount
    )

    if transaction.apply
      render(json: {message: "Transfer successful", balance: @wallet.balance}, status: :ok)
    else
      render(json: {error: transaction.errors.full_messages}, status: :unprocessable_entity)
    end
  end

  # GET /wallets/balance
  def balance
    render(json: {balance: @wallet.balance}, status: :ok)
  end

  private

  def set_wallet
    @wallet = current_user.wallet
    render(json: {error: "Wallet not found"}, status: :not_found) if @wallet.nil?
  end

end
