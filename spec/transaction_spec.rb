# frozen_string_literal: true

require 'transaction'

describe Transaction do
  describe '#initialize' do
    it 'creating a transaction has given amount, date and balance' do
      transaction = Transaction.new(amount: 50, date: "01/01/2000", balance: 100)
      expect(transaction.amount).to be(50)
      expect(transaction.date).to be("01/01/2000")
      expect(transaction.balance).to be(100)
    end
  end
end