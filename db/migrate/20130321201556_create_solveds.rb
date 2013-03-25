class CreateSolveds < ActiveRecord::Migration
  def change
    create_table :solveds do |t|
      t.integer :problem_id
      t.integer :user_id

      t.timestamps
    end
  end
end
