module Push
  class Configuration < ActiveRecord::Base
    self.table_name = 'push_configurations'
    named_scope :enabled, :conditions => {:enabled => true}
    validates_presence_of :app
    validates_presence_of :connections
    validates_numericality_of :connections, :greater_than => 0, :only_integer => true
    validates_uniqueness_of :type, :scope => :app, :message => "Only one push provider type per configuration name"
  end
end