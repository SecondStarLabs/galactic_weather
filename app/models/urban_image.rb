class UrbanImage < ApplicationRecord
  has_many_attached :files
  belongs_to :city
end
