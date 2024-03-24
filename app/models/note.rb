class Note < ApplicationRecord
  validates :title, :description, presence: true, on: :create
end
