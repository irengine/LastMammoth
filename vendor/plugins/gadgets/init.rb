require 'gadgets.rb'
require 'query.rb'

ActionView::Base.send :include, ActionView::Helpers
ActiveRecord::Base.extend ActiveRecordExtensions