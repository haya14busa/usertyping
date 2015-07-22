class Collection < ActiveRecord::Base
  belongs_to :user
  has_many :texts, dependent: :destroy
  accepts_nested_attributes_for :texts

  validates :title,
    :presence => true,
    :uniqueness => {
      :case_sensitive => false
    }

  def self.find(query)
    self.find_by_title(query) || super(query)
  end

  def to_param
    "#{self.title}"
  end
end
