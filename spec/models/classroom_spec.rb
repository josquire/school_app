require 'rails_helper'

RSpec.describe Classroom, type: :model do
  describe "validations" do
    it { should validate_presence_of(:teacher) }
    it { should validate_presence_of(:grade) }
    end
  end
