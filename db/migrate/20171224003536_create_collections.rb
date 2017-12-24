class CreateCollections < ActiveRecord::Migration[5.1]
  def change
    create_table :collections do |t|
      t.string :title
      t.datetime :finish_at

      t.timestamps
    end
  end
end
