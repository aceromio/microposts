class AddAgeToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :age, :integer
    add_column :messages, :gender, :string
    add_column :messages, :profile, :string
    add_column :messages, :area, :string
  end
end
