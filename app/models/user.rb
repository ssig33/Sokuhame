class User < ActiveRecord::Base
  has_one :post
end
