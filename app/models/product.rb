class Product < ApplicationRecord
  belongs_to :category
  validates :description, :price, :category, presence: true

  def full_description
    "#{self.description} - Price: #{self.price}, Category: #{self.category}"
  end
end
