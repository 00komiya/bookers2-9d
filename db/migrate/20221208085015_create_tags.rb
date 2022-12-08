class CreateTags < ActiveRecord::Migration[6.1]
  def change
    create_table :tags do |t|

      t.string :tagname, null:false, uniqueness: true
      t.timestamps
    end
  end
end
