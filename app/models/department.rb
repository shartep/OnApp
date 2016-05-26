class Department < ActiveRecord::Base
  has_many :issues
end
