class Post < ApplicationRecord
  def update_self(params)
    self.assign_attributes(params.compact)
  end

  def add_comment(comment_params)
    self.comments.build(comment_params)
  end

  def remove_comment(comment_id)
    self.comments.to_a.find { |c| c.id == comment_id.to_i }.mark_for_destruction
  end

  validates :title, presence: true
  validates :overview, presence: true
  validates :content, presence: true

  belongs_to :user

  has_many :comments, class_name: "Comment", dependent: :destroy, autosave: true
end
