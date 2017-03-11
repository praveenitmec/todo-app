class CreateTodos < ActiveRecord::Migration[5.0]
  def change
    create_table :todos do |t|
      t.string :name
      t.datetime :target_date
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
