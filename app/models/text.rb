class Text < ActiveRecord::Base
  belongs_to :collection

  validates :title,
    :presence => true,
    :uniqueness => {
      :case_sensitive => false
    }

  validates :body, :presence => true

  def self.find(query)
    self.find_by_title(query) || super(query)
  end

  def to_param
    "#{self.title}"
  end
end
