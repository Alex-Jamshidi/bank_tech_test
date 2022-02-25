# frozen_string_literal: true

require_relative 'exception'

class Account
  attr_reader :balance

  def initialize
    @balance = 0
  end

  def deposit(amount)
    @balance += amount
  end

  def withdraw(amount)
    validate_withdrawal(amount)
    @balance -= amount
  end

  private

  def validate_withdrawal(amount)
    Exception.insufficient_funds unless amount < @balance
  end
end
