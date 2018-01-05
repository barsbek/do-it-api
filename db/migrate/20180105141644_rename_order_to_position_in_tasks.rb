class RenameOrderToPositionInTasks < ActiveRecord::Migration[5.1]
  def change
    rename_column :tasks, :order, :position
  end
end
