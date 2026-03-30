class User < ApplicationRecord
  has_many :posts, class_name: "Post", dependent: :destroy
  has_many :comments, class_name: "Comment", dependent: :destroy
  has_many :messages, class_name: "Message", dependent: :destroy
  has_many :sessions, class_name: "Session", dependent: :destroy
end
