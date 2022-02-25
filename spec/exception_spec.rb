require 'exception'

describe Exception do
  describe '#insufficient funds' do
    it 'raises error message to indicate insufficient funds' do
      expect { described_class.insufficient_funds }.to raise_error("Insufficient Funds - Please check your account balance")
    end
  end
end