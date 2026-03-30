class Post < ApplicationRecord
  validates :overview, presence: true
  validates :content, presence: true

  belongs_to :user

  has_many :comments, class_name: "Comment", dependent: :destroy
end
