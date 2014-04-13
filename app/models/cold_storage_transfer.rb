class ColdStorageTransfer < ActiveRecord::Base
  belongs_to :project

  def confirmed?
    confirmations and confirmations >= 1
  end
end
