class Resource < ActiveRecord::Base
#  acts_as_list
  
  MODES = ['active', 'inactive', 'disabled']
  
  named_scope :system_preferences, :conditions => { :scope => 'System'}
  named_scope :codes, lambda { |code_scope|
      { :conditions => { :scope => 'code.' + code_scope } }
    }
  
  validates_presence_of :scope, :klass, :key, :value, :mode
  validates_uniqueness_of :key, :scope => :scope
  validates_inclusion_of :mode, :in => MODES
  
  @@preferences = {}
  
  def self.load()
    logger.debug "loading system preferences..."
    system_preferences.each do |preference|
      case preference.klass
        when "String"
        @@preferences[preference.key] = preference.value
        when "Integer"
        @@preferences[preference.key] = preference.value.to_i
      end
    end
  end
  
  def self.[](key)
    load if @@preferences.nil? || @@preferences.size == 0
    @@preferences[key]
  end
  
  def self.lookup_codes(name)
    name = name.to_s if name.kind_of?(Symbol)
    Resource.find(:all, :conditions => {:scope => to_code(name)}).collect {|r| [r.value, r.key]}
  end
  
  def self.lookup_ids(name)
    name = name.to_s if name.kind_of?(Symbol)
    Resource.find(:all, :conditions => {:scope => to_code(name)}).collect {|r| [r.value, r.id]}
  end
  
  private
  def self.to_code(s)
    'code.' + s
  end
end
