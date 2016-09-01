class Classroom < ApplicationRecord
  validates_presence_of :teacher, :grade
  belongs_to :school
end
