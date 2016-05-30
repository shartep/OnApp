class SetNotNullForNameInDepartmens < ActiveRecord::Migration
  def change
    change_column_null :departments, :name, false
  end
end
