class Commit < ActiveRecord::Base
  belongs_to :project

  validates :sha, uniqueness: {scope: :project_id}
end
