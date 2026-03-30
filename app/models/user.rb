class User < ApplicationRecord
  # TODO: Verificar validação/associação de picture de storage

  validates :nickname, presence: true
  validates :password, presence: true
  validates :picture, format: { with: URI::DEFAULT_PARSER.make_regexp }, allow_blank: true
  validates :role, presence: true

  has_many :posts, class_name: "Post", dependent: :destroy
  has_many :comments, class_name: "Comment", dependent: :destroy
  has_many :messages, class_name: "Message", dependent: :destroy
  has_many :sessions, class_name: "Session", dependent: :destroy
end
