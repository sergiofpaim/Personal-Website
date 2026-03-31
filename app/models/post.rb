class Post < ApplicationRecord
  validates :overview, presence: true
  validates :content, presence: true

  belongs_to :user

  has_many :comments, class_name: "Comment", dependent: :destroy

  def add_comment(comment)
    comments.build(comment)
  end

  def remove_comment(comment)
    comments.target.delete(comment)
  end
end
