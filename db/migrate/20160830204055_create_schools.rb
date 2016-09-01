class CreateSchools < ActiveRecord::Migration[5.0]
  def change
    create_table :schools do |t|
      t.string :name, null: false
      t.string :level, null: false
      t.string :student_body

      t.timestamps
    end
  end
end
