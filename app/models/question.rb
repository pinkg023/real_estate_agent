class Question < ApplicationRecord
  validates_presence_of :description
  validates_length_of :description, maximum: 500

  belongs_to :user
end
