FactoryGirl.define do
  factory :classroom do
    teacher "White"
    grade "11"
    number_students "35"
    school_id @school_id
  end
end
