class CreateSleeps < ActiveRecord::Migration[5.2]
  def change
    create_table :sleeps do |t|
      t.references :user, null: false, foreign_key: true
      t.time :slept_time, null: false
      t.time :wakeup_time, null: false
      t.date :date, null: false
      t.timestamps
    end
  end
end
