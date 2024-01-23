class AddUserintroductionToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :userintroduction, :text
  end
end
