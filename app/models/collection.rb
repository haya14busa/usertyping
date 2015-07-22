class Collection < ActiveRecord::Base
  belongs_to :user
  has_many :texts, dependent: :destroy
  accepts_nested_attributes_for :texts

  validates :title,
    :presence => true,
    :uniqueness => {
      :case_sensitive => false
    },
    :exclusion => {
      # Now, it doesn't use `new` by system but keep it reserved for future
      :in => %w(new),
      :message => "You cannot use %{value} because it's a reserved word"
    }

  def self.find(query)
    self.find_by_title(query) || super(query)
  end

  def to_param
    "#{self.title}"
  end

  def self.search(query)
    if query
      Collection.where(['title LIKE ?', "%#{query}%"])
    else
      Collection.all
    end
  end
end
