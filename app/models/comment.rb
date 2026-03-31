class Comment < ApplicationRecord
  validates :content, presence: true

  belongs_to :user
  belongs_to :post
  belongs_to :replied_comment, class_name: "Comment", optional: true
end
