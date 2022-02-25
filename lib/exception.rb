# frozen_string_literal: true

class Exception
  def self.insufficient_funds
    raise('Insufficient Funds - Please check your account balance')
  end
end
