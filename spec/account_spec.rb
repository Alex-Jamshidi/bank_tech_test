# frozen_string_literal: true

require 'account'

describe Account do
  let(:transaction) { instance_double(Transaction) }
  let(:transaction_2) { instance_double(Transaction) }
  let(:transaction_3) { instance_double(Transaction) }

  describe '#initialize' do
    it 'setting up an account gives a default balance of 0' do
      account = Account.new
      expect(account.balance).to be(0)
      expect(account.history).to eq([])
    end
  end

  describe '#deposit' do
    it 'depositing 50 should increase balance by 50, to 50' do
      account = Account.new
      expect { account.deposit(amount: 50) }.to change(account, :balance).by(50)
      expect(account.balance).to be(50)
    end

    it 'depositing 50 should store transaction in history' do
      allow(Transaction)
        .to receive(:new)
        .and_return(transaction)

      allow(transaction)
        .to receive(:amount)
        .and_return(50)
      allow(transaction)
        .to receive(:date)
        .and_return('01/01/2000')
      allow(transaction)
        .to receive(:balance)
        .and_return(50)

      account = Account.new
      account.deposit(amount: 50)

      expect(account.history.last.amount).to eq(50)
      expect(account.history.last.date).to eq('01/01/2000')
      expect(account.history.last.balance).to eq(50)
    end
  end

  describe '#withdraw' do
    it 'withdrawing 50 from account with 0 balance should raise error' do
      account = Account.new
      expect(account.balance).to be(0)
      expect { account.withdraw(amount: 50) }.to raise_error('Insufficient Funds - Please check your account balance')
    end

    it 'withdrawing 50 from account with 200 balance should decrease balance by 50, to 150' do
      account = Account.new
      account.deposit(amount: 200)
      expect { account.withdraw(amount: 50) }.to change(account, :balance).by(-50)
      expect(account.balance).to be(150)
    end

    it 'depositing 50 should store transaction in history' do
      allow(Transaction)
        .to receive(:new)
        .and_return(transaction)

      allow(transaction)
        .to receive(:amount)
        .and_return(-50)
      allow(transaction)
        .to receive(:date)
        .and_return('01/01/2000')
      allow(transaction)
        .to receive(:balance)
        .and_return(0)

      account = Account.new
      account.deposit(amount: 50)
      account.withdraw(amount: 50)

      expect(account.history.last.amount).to eq(-50)
      expect(account.history.last.date).to eq('01/01/2000')
      expect(account.history.last.balance).to eq(0)
    end
  end

  describe '#print_statement' do
    it 'creating deposits and withdraws returns correct statement' do
      allow(Transaction)
        .to receive(:new)
        .and_return(transaction)

      allow(transaction)
        .to receive(:amount)
        .and_return(1000)
      allow(transaction)
        .to receive(:date)
        .and_return('10/01/2023')
      allow(transaction)
        .to receive(:balance)
        .and_return(1000)

      account = Account.new
      account.deposit(amount: 1000, date: '10/01/2023')

      allow(Transaction)
        .to receive(:new)
        .and_return(transaction_2)

      allow(transaction_2)
        .to receive(:amount)
        .and_return(2000)
      allow(transaction_2)
        .to receive(:date)
        .and_return('13/01/2023')
      allow(transaction_2)
        .to receive(:balance)
        .and_return(3000)

      account.deposit(amount: 2000, date: '13/01/2023')

      allow(Transaction)
        .to receive(:new)
        .and_return(transaction_3)

      allow(transaction_3)
        .to receive(:amount)
        .and_return(-500)
      allow(transaction_3)
        .to receive(:date)
        .and_return('14/01/2023')
      allow(transaction_3)
        .to receive(:balance)
        .and_return(2500)

      account.withdraw(amount: 500, date: '14/01/2023')

      expect { account.print_statement }.to output(
        "date || credit || debit || balance\n"\
        "14/01/2023 ||  || 500.00 || 2500.00\n"\
        "13/01/2023 || 2000.00 ||  || 3000.00\n"\
        "10/01/2023 || 1000.00 ||  || 1000.00\n"
      ).to_stdout
    end
  end
end
