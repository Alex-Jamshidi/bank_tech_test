# frozen_string_literal: true

class Message
  def self.statement_header
    puts 'date || credit || debit || balance'
  end

  def self.statement_entry(date:, balance:, credit: '', debit: '')
    puts "#{date} || #{credit} || #{debit} || #{balance}"
  end
end
