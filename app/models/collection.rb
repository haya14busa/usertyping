class Collection < ActiveRecord::Base
  belongs_to :user
  has_many :texts, dependent: :destroy
  accepts_nested_attributes_for :texts
end
