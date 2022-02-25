# frozen_string_literal: true

require_relative 'transaction'
require_relative 'exception'
require_relative 'message'
require 'date'

class Account
  attr_reader :balance, :history

  @@todays_date = Date.today.strftime("%d/%m/%Y")

  def initialize
    @balance = 0
    @history = []
  end

  def deposit(amount:, date: @@todays_date)
    update_balance(amount: amount)

    record_transaction(amount: amount, date: date)
  end

  def withdraw(amount:, date: @@todays_date)
    validate_withdrawal(amount: amount)
    update_balance(amount: -amount)
    record_transaction(amount: -amount, date: date)
  end

  def print_statement
    Message.statement_header
    @history.reverse.each { |transaction|
    credit = check_credit(amount: transaction.amount)
    debit = check_debit(amount: transaction.amount)
    Message.statement_entry(date: transaction.date, credit: credit, debit: debit, balance: '%.2f' % transaction.balance)
    }
  end

  private

  def update_balance(amount:)
    @balance += amount
  end

  def record_transaction(amount:, date:)
    @history << Transaction.new(amount: amount, date: date, balance: @balance)
  end

  def validate_withdrawal(amount:)
    Exception.insufficient_funds unless amount <= @balance
  end

  def check_credit(amount:)
    '%.2f' % amount unless amount < 0
  end

  def check_debit(amount:)
    '%.2f' % -amount unless amount > 0
  end
end
