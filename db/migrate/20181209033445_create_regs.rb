class CreateRegs < ActiveRecord::Migration[5.1]
  def change
    create_table :regs do |t|

      t.timestamps
    end
  end
end
