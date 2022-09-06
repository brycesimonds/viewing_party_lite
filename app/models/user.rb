class User < ApplicationRecord
    validates_presence_of :name
    validates_presence_of :email
    validates_presence_of :password_digest
    validates :email, uniqueness: true

    has_many :party_users
    has_many :viewing_parties, through: :party_users

    has_secure_password
  end