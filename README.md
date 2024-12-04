# README

# **Ruby Wallet System**

## **Overview**

The Ruby Wallet System is an internal transactional system built with Ruby on Rails, designed to manage financial operations for entities like users, teams, and stocks. Each entity has its own wallet, supporting secure and efficient transactions such as transfers, deposits, and withdrawals, all while adhering to database integrity and validation rules.

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
```ruby
# Deposit money into User's wallet
Transaction.create!(target_wallet: user_wallet, amount: 100.00)

# Transfer money from User to Team
Transaction.create!(source_wallet: user_wallet, target_wallet: team_wallet, amount: 50.00)
```

### **Checking Wallet Balance**
```ruby
user_wallet.balance # Returns the calculated or stored balance
team_wallet.balance
```

---

## **Database Schema**

### **Users**
| Field      | Type    |
|------------|---------|
| id         | integer |
| name       | string  |
| email      | string  |
| created_at | datetime |
| updated_at | datetime |

### **Wallets**
| Field          | Type       |
|----------------|------------|
| id             | integer    |
| walletable_id  | integer    |
| walletable_type| string     |
| balance        | decimal    |
| created_at     | datetime   |
| updated_at     | datetime   |

### **Transactions**
| Field            | Type       |
|------------------|------------|
| id               | integer    |
| source_wallet_id | integer    |
| target_wallet_id | integer    |
| amount           | decimal    |
| created_at       | datetime   |
| updated_at       | datetime   |

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
