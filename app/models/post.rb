class Post < ActiveRecord::Base
  belongs_to :category

  validates :title, presence: true, length: {maximum: 100}, uniqueness: {scope: :category_id}
end
