# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  uid                    :string(255)
#  name                   :string(255)
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_uid                   (uid) UNIQUE
#

require 'spec_helper'

describe User do

  let(:user) { create(:user) }
  let(:account) { user.account }

  let(:valid_args) { {:agency => account.agency, :number => account.number} }
  let(:invalid_args) { {:agency => "", :number => ""} }

  describe ".by_account" do

    context 'when args are not valid' do
      it "returns a user" do
        expect(User.by_account(valid_args)).to eql(user)
      end
    end

    context 'when args are valid' do
      it "returns nil" do
        expect(User.by_account(invalid_args)).to eql(nil)
      end
    end

  end

  describe "#balance" do

    it "returns account balance" do
      expect(user.balance).to eql(account.balance)
    end

  end

end
