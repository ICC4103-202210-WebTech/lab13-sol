class AddLastNameToAdmin < ActiveRecord::Migration[7.0]
  def change
    add_column :admins, :lastname, :string
  end
end
