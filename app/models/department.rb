class Department < ActiveRecord::Base
  has_many :issues

  validates :name, presence: true, uniqueness: true, length: { maximum: 100 }
end
