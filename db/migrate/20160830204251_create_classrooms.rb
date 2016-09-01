class CreateClassrooms < ActiveRecord::Migration[5.0]
  def change
    create_table :classrooms do |t|
      t.string :teacher, null: false
      t.string :grade, null: false
      t.string :number_students
      t.belongs_to :school

      t.timestamps
    end
  end
end
