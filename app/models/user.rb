class User < ActiveRecord::Base
  attr_accessible :age, :agility, :arithmatic, :interest, :literature, :logic, :name, :phoneID, :strength, :teamwork, :email

  has_many :positions, dependent: :destroy

  has_many :sent_msgs, :class_name => "Message",
           :foreign_key => :sender_id

  has_many :received_msgs, :class_name => "Message",
           :foreign_key => :receiver_id
end
