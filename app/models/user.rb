class User < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true, email_format: true
  validates :first_name, presence: true, length: { maximum: 100 }
  validates :last_name, presence: true, length: { maximum: 100 }
end
