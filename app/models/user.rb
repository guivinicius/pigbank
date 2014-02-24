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
#  balance                :decimal(10, 2)   default(0.0)
#  agency_number          :integer
#  account_number         :integer
#  uid                    :string(255)
#  name                   :string(255)
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_uid                   (uid) UNIQUE
#

class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name, :uid, :agency_number, :account_number,
    :presence => true

  validates :balance,
   :numericality => { :greater_than => 0 },
   :on => :update

  validates :uid,
    :uniqueness => true

  has_many :transactions,
    :dependent => :destroy

  has_many :debits, -> { where(:activity_type => 1) }

  has_many :credits, -> { where(:activity_type => 0) }

  has_many :transferences,
    :foreign_key => :from_user_id,
    :dependent => :destroy

end
