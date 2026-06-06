require_relative "user"
require_relative "transaction"
require_relative "cba_bank"

users = [
  User.new("Hussein", 200),
  User.new("Mohamed", 500),
  User.new("jo", 100)
]

outside_users = [
  User.new("Menna", 400)
]

transactions = [
  Transaction.new(users[0], -20),
  Transaction.new(users[0], -30),
  Transaction.new(users[0], -50),
  Transaction.new(users[0], -100),
  Transaction.new(users[0], -100),
  Transaction.new(outside_users[0], -100)
]

bank = CBABank.new(users)

callback = Proc.new do |status, transaction, reason|
  if status == "success"
    puts "Call endpoint for success of #{transaction}"
  else
    puts "Call endpoint for failure of #{transaction} with reason #{reason}"
  end
end

bank.process_transactions(transactions, &callback)