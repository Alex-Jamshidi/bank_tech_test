# frozen_string_literal: true

require 'message'

describe Message do
  describe '#statement_header' do
    it 'puts statement header' do
      expect { described_class.statement_header }
        .to output("date || credit || debit || balance\n").to_stdout
    end
  end

  describe '#statement_entry' do
    it 'puts statement entry' do
      expect { described_class.statement_entry(date: '14/01/2023', debit: '500.00', balance: '2500.00') }
        .to output("14/01/2023 ||  || 500.00 || 2500.00\n").to_stdout
    end
  end
end
