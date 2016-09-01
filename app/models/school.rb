class School < ApplicationRecord
  has_many :classrooms, dependent: :destroy
  validates_presence_of :name, :level
end
