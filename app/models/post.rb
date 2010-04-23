class Post < ActiveRecord::Base
  belongs_to :user

  def cut_address
    "#{address.unpack("a50a*")[0]}"
  end

  def cut_cost
    "#{cost.unpack("a50a*")[0]}"
  end

  def cut_memo
    "#{memo.unpack("a50a*")[0]}"
  end
end
