module Push
  class Feedback < ActiveRecord::Base
    include Push::Daemon::DatabaseReconnectable
    self.table_name = 'push_feedback'

    named_scope :ready_for_followup, :conditions => {:processed => false}
    validates_presence_of :app
    validates_presence_of :device
    validates_presence_of :follow_up
    validates_presence_of :failed_at

    def is_processed(name)
      with_database_reconnect_and_retry(name) do
        self.processed = true
        self.processed_at = Time.now
        self.save
      end
    end
  end
end