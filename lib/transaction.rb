# frozen_string_literal: true
require 'Date'

class Transaction
  attr_reader :amount, :date, :balance

  def initialize(amount:, date: Date.today.strftime("%d/%m/%Y"), balance:)
    @amount = amount
    @date = date
    @balance = balance
  end
end

