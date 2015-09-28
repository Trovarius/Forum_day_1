class Post < ActiveRecord::Base
  belongs_to :category
  has_many :comments
  accepts_nested_attributes_for :comments

  validates :title, presence: true, length: {maximum: 100}, uniqueness: {scope: :category_id}
  validates :comments, :length => {:minimum => 1}

end
