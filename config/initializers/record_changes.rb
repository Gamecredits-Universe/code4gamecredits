class ActiveRecord::Base
  def self.record_changes(options)
    has_many :record_changes, as: :record

    after_save do
      state = to_json(options)
      last_state = RecordChange.where(record: self).order(created_at: :desc).first.try(:raw_state)
      if state != last_state
        RecordChange.create!(record: self, raw_state: state)
      end
    end
  end
end
