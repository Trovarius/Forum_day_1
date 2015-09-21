class Category < ActiveRecord::Base
  has_many :posts

  validates :name, presence: true, length: {maximum: 100}
  
  def title
    '#{name} (posts: #{posts.length})'
  end
end
