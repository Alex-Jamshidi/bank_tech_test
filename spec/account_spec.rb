require 'account'

describe Account do
  describe 'setting up an account' do
    it 'setting up an account gives a default balance of 0' do
      account = Account.new
      expect(account.balance).to be(0)
    end
  end

  describe 'deposit' do
    it 'depositing 50 should increase balance by 50, to 50' do
      account = Account.new
      expect { account.deposit(50) }.to change(account, :balance).by(50)
      expect(account.balance).to be(50)
    end
  end

  describe 'withdraw' do
    it 'withdrawing 50 from account with 0 balance should raise error' do
      account = Account.new
      expect(account.balance).to be(0)
      expect { account.withdraw(50) }.to raise_error("Insufficient Funds - Please check your account balance")
    end

    it 'withdrawing 50 from account with 200 balance should decrease balance by 50, to 150' do
      account = Account.new
      account.deposit(200)
      expect { account.withdraw(50) }.to change(account, :balance).by(-50)
      expect(account.balance).to be(150)
    end
  end

end
