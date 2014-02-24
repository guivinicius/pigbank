# == Schema Information
#
# Table name: accounts
#
#  id         :integer          not null, primary key
#  number     :integer          not null
#  agency     :integer          not null
#  balance    :decimal(10, 2)   default(0.0), not null
#  user_id    :integer          not null
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_accounts_on_number_and_agency  (number,agency) UNIQUE
#  index_accounts_on_user_id            (user_id)
#

require 'spec_helper'

describe Account do

  let(:account) { build(:account) }

  it 'is valid with valid attributes' do
    expect(account).to be_valid
  end

  it "does not allow negative balance" do
    account.balance = -10

    expect(account).not_to be_valid
  end

  describe "#number" do

    it "has to be unique on agency" do
      account.save
      expect(build(:account, :agency => account.agency, :number => account.number)).not_to be_valid
    end

  end

end
