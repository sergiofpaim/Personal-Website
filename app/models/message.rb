class Message < ApplicationRecord
  belongs_to :user
  belongs_to :replied_message, class_name: "Message", optional: true
end
