class RemoveChoiceFromLike < ActiveRecord::Migration[6.0]
  def change
    change_table :likes do |t|
      t.remove :choice
    end
  end
end
