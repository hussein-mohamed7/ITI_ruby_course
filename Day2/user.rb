class User
  attr_reader :name
  attr_accessor :balance

  def initialize(name, balance)
    @name = name
    @balance = balance
  end

  def update_balance(amount)
    if @balance + amount < 0
      raise "Not enough balance"
    end

    @balance += amount
  end
end