class CreateAttendances < ActiveRecord::Migration
  def self.up
    create_table :attendances do |t|
      t.date :week_beginning
      t.integer :person_id
      t.integer :att_year
      t.integer :att_3_week
      t.integer :att_week

      t.timestamps
    end
  end

  def self.down
    drop_table :attendances
  end
end