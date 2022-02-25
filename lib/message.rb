class Message
  def self.statement_header
    puts 'date || credit || debit || balance'
  end

  def self.statement_entry(date:, credit: "", debit: "", balance:)
    puts "#{date} || #{credit} || #{debit} || #{balance}"
  end
end