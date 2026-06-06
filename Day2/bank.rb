class Bank
  def process_transactions(transactions, &callback)
    raise NotImplementedError, "Must implement in subclass"
  end
end