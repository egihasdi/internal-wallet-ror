# README

# **Internal Wallet Transaction System (API)**

## **Overview**

The Internal Wallet Transaction System (API) is an internal transactional system built with Ruby on Rails, designed to manage financial operations for entities like users, teams, and stocks. Each entity has its own wallet, supporting secure and efficient transactions such as transfers, deposits, and withdrawals, all while adhering to database integrity and validation rules.

---

## **Features**

- **Wallet Management**: Every entity (`User`, `Team`, `Stock`) has a dedicated wallet to manage funds.
- **Transaction Types**: Supports credit (deposit), debit (withdraw), and transfer operations.
- **Data Integrity**: Transactions comply with **ACID standards**, ensuring reliability and consistency.
- **Dynamic Balance Calculation**: Wallet balances are derived from transactions for real-time accuracy.
- **Scalable Design**: Implements **polymorphic relationships** and **Single Table Inheritance (STI)** for flexibility.
- **Validations**: Enforces rules to ensure proper transaction handling.

---

## **Models and Relationships**

- **User**, **Team**, and **Stock**: Entities that own wallets.
- **Wallet**: Polymorphic model that tracks the balance for each entity.
- **Transaction**: Tracks money movement between wallets with fields like `source_wallet`, `target_wallet`, and `amount`.

---

## **Installation**

1. Clone the repository:
   ```bash
   git clone https://github.com/egihasdi/internal-wallet-ror.git
   cd internal-wallet-ror
   ```

2. Install dependencies:
   ```bash
   bundle install
   ```

3. Set up the database:
   ```bash
   rails db:create
   rails db:migrate
   ```

4. Start the Rails server:
   ```bash
   rails server
   ```

5. Open the app in your browser at `http://localhost:3000`.

---

## **Usage**

### **Creating Entities and Wallets**
In the Rails console:
```ruby
user = User.create(name: "Alice", email: "alice@example.com")
team = Team.create(name: "Team Alpha", description: "A great team!")

# Create wallets for entities
user_wallet = user.create_wallet
team_wallet = team.create_wallet
```

### **Performing Transactions**
#### **Depositing Funds (CreditTransaction)**
Use `CreditTransaction` to deposit money into a wallet:
```ruby
# Deposit 100 into User's wallet
credit_transaction = CreditTransaction.new(target_wallet: user_wallet, amount: 100.00)
credit_transaction.apply

# Check the balance of User's wallet after deposit
puts user_wallet.balance
```
#### Withdrawing Funds (DebitTransaction)
Use `DebitTransaction` to withdraw funds from a wallet:
```ruby
# Withdraw 50 from User's wallet
debit_transaction = DebitTransaction.new(source_wallet: user_wallet, amount: 50.00)
debit_transaction.apply

# Check the balance of User's wallet after withdrawal
puts user_wallet.balance
```
#### Transferring Funds (TransferTransaction)
Use `TransferTransaction` to transfer funds between two wallets:
```ruby
# Transfer 30 from User's wallet to Team's wallet
transfer_transaction = TransferTransaction.new(source_wallet: user_wallet, target_wallet: team_wallet, amount: 30.00)
transfer_transaction.apply

# Check the balance of both wallets after transfer
puts user_wallet.balance
puts team_wallet.balance
```

---

## **Database Schema**

### **users**
| Field      | Type    |
|------------|---------|
| id         | integer |
| name       | string  |
| email      | string  |
| password_digest | string |
| created_at | datetime |
| updated_at | datetime |

### **wallets**
| Field          | Type       |
|----------------|------------|
| id             | integer    |
| walletable_id  | integer    |
| walletable_type| string     |
| created_at     | datetime   |
| updated_at     | datetime   |

### **transactions**
| Field            | Type       |
|------------------|------------|
| id               | integer    |
| source_wallet_id | integer    |
| target_wallet_id | integer    |
| amount           | decimal    |
| type             | string     |
| source_wallet_type | string |
| target_wallet_type | string |
| created_at       | datetime   |
| updated_at       | datetime   |

### **stocks**
| Field         | Type       |
| ---- | ---- |
| symbol        | string     |
| company_name  | string     |
| current_price | decimal    |
| market        | string     |
| created_at | datetime |
| updated_at | datetime |

### **teams**
| Field      | Type      |
| ---- | ---- |
| name      | string      |
| description | string |
| created_at | datetime |
| updated_at | datetime |

---

## **API Endpoints**

### **Authentication**

#### **Generate Token**
- **Endpoint:** `POST /auth/token`
- **Description:** Generates a JWT token for authentication.
- **Request:**
  ```json
  {
    "email": "user@example.com",
    "password": "password123"
  }
- **Response:**
  ```json
  {
     "token": "your.jwt.token"
  }
  ```
### **Wallet Endpoints**

#### **Get Wallet Balance**
- **Endpoint:** `GET /wallets/balance`
- **Description:** Fetches the balance from current logged-in user.
- **Headers:**
  ```json
  {
     "Authorization": "Bearer your.jwt.token"
  }
  ```
- **Response:**
  ```json
  {
     "balance": 150.00
  }
  ```

#### **Deposit Funds**
- **Endpoint:** `POST /wallets/deposit`
- **Description:** Deposits funds from current logged-in user.
- **Headers:**
  ```json
  {
     "Authorization": "Bearer your.jwt.token"
  }
  ```
- **Request:**
  ```json
  {
    "amount": 100.00
  }
- **Response:**
  ```json
  {
    "message": "Deposit successful",
    "balance": "480.0"
  }
  ```
- **Errors:**
  ```json
  {
    "error": "Amount must be greater than zero"
  }
  ```

#### **Withdraw Funds**
- **Endpoint:** `POST /wallets/withdraw`
- **Description:** Withdraws funds from current logged-in user.
- **Headers:**
  ```json
  {
     "Authorization": "Bearer your.jwt.token"
  }
  ```
- **Request:**
  ```json
  {
    "amount": 100.00
  }
  ```
- **Response:**
  ```json
  {
       "message": "Withdrawal successful",
       "balance": "430.0"
  }
  ```
- **Errors:**
  ```json
  {
    "error": "Insufficient balance in source wallet"
  }
  ```
  ```json
  {
    "error": "Amount must be greater than zero"
  }
  ```
  

#### **Transfer Funds**
- **Endpoint:** `POST /wallets/transfer`
- **Description:** Transfers funds from current logged-in user to another wallet.
- **Headers:**
  ```json
  {
     "Authorization": "Bearer your.jwt.token"
  }
  ```
- **Request:**
  ```json
  {
    "target_wallet_id": 2,
    "amount": 50.00
  }
  ```
- **Response:**
  ```json
  {
       "message": "Transfer successful",
       "balance": "400.0"
  }
  ```
- **Errors:**
  ```json
  {
    "error": "Insufficient balance in source wallet"
  }
  ```
  ```json
  {
    "error": "Amount must be greater than zero"
  }
  ```
  
---

## **LatestStockPrice Library**
### **Overview**

The `LatestStockPrice` library is a Ruby module for fetching the latest stock prices. It provides methods to retrieve the price of a single stock, multiple stocks, or all available stock prices. This library is built in a reusable and modular "gem style" for easy integration into Ruby applications.

---

### **Features**

- Fetch the current price of a specific stock by symbol.
- Retrieve the prices of multiple stocks at once.
- Get the prices of all available stocks.
- Simple and intuitive API methods.
- Built-in HTTP request handling and JSON response parsing.

### **Usage**
#### **Client Initialization**
Initializing the Client requires `rapidapi-key` 
```ruby
require_relative 'lib/latest_stock_price'

client = LatestStockPrice::Client.new(api_key: "RAPID_API_APIKEY")
```

#### **Fetching a Single Stock Price
To fetch the price of a specific stock by its symbol:
```ruby
price = client.price('AAPL') # Replace 'AAPL' with the stock symbol
puts "The price of AAPL is $#{price}"
```

### **Fetching Multiple Stock Prices
To fetch the prices of multiple stocks at once:
```ruby
prices = client.prices(['AAPL', 'GOOGL', 'MSFT'])
puts prices # Returns a hash with stock symbols and their prices
```

#### **Fetching All Stock Prices
To retrieve the prices of all available stocks:
```ruby
all_prices = client.price_all
puts all_prices # Returns a hash with all stock symbols and their prices
```

---

## **Testing**

Run the test suite:
```bash
rails test
```

## **License**

This project is licensed under the MIT License. See the `LICENSE` file for details.

---

## **Contributors**

- [Egi Hasdi](https://github.com/egihasdi)
