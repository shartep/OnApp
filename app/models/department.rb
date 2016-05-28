class Department < ActiveRecord::Base
  validates_length_of :name, maximum: 100
end
