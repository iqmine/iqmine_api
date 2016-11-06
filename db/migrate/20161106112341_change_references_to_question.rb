class ChangeReferencesToQuestion < ActiveRecord::Migration[5.0]
  def change
    remove_reference :questions, :category
    add_reference :questions, :sub_category
  end
end
