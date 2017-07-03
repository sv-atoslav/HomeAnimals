class CreateManWithAnimals < ActiveRecord::Migration[5.1]
  def change
    create_table :man_with_animals do |t|
      t.integer :man
      t.integer :animal

      t.timestamps
    end
  end
end
