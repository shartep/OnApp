class Department < ActiveRecord::Base
  has_many :issues

  validates :name, presence: true, length: 1..100
end
