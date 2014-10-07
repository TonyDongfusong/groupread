class Book < ActiveRecord::Base
  has_many :read_records
end
