class Article < ApplicationRecord
  include Visible

  has_many :comments, dependent: :destroy

  # Active Record automatically defines model attributes for every table column, so I don't have to declare those attributes in a model file
  validates :title, presence: true
  validates :body, presence: true, length: { minimum: 10 }
end
