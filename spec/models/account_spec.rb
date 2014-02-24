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
end
