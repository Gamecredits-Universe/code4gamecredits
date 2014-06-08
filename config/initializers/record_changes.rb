class ActiveRecord::Base
  def self.record_changes(options)
    has_many :record_changes, as: :record

    after_save do
      state = to_json(options)
      RecordChange.create!(record: self, raw_state: state)
    end
  end
end
