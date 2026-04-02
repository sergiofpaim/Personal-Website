class Comment < ApplicationRecord
  validates :content, presence: true

  belongs_to :user
  belongs_to :post

  belongs_to :replied_comment,
             class_name: "Comment",
             foreign_key: :comment_id,
             optional: true

  has_many :replies,
           class_name: "Comment",
           foreign_key: :comment_id,
           dependent: :destroy
end
