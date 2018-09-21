class Book < ActiveRecord::Base
  has_and_belongs_to_many :users
  belongs_to :category

  def slug
    title.downcase.gsub(" ","-")
  end

  def self.find_by_slug(slug)
    Book.all.find{|book| book.slug == slug}
  end


end
