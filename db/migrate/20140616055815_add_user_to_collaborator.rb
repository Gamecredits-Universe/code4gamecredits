class AddUserToCollaborator < ActiveRecord::Migration
  def change
    add_reference :collaborators, :user, index: true
  end
end
