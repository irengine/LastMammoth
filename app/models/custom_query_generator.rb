class CustomQueryGenerator
  class << self
    def generate_view(name)
      cq = CustomQuery.find_by_name(name)
      view_for(cq)
    end

    def generate_sql(name, values)
      cq = CustomQuery.find_by_name(name)
      sql_for(cq, values)
    end
    
    def view_for(q)
      action = q.action.nil? ? "/r/#{q.name}" : "#{q.action}/#{q.name}"
      v = ""
      v << "<div id=\"#{q.name}_filter\" class=\"editform\">\r\n"
      v << "  <% fieldset_form_for(:search, :url => '#{action}') do |f| %>\r\n"
      v << "    <%= f.legend I18n.t('#{q.name}') %>\r\n"
      q.parameters.each do |p|
        case p.flag
        when "string", "integer"
          v << "    <%= f.text_field \"#{p.name.capitalize.gsub('.', '__')}\" %>\r\n"
        when "list"
          v << "    <%= f.select \"#{p.name.capitalize.gsub('.', '__')}\", #{p.code}, {:include_blank => true} %>\r\n"
        end
      end
      v << "    <%= f.submit I18n.t('button_Query') %>\r\n"
      v << "  <% end %>\r\n"
      v << "</div>\r\n"
      v
    end

    def sql_for(q, values)
      ks = []
      vs = []
      q.parameters.each do |p|
        if !values[p.name.capitalize.gsub('.', '__')].blank?
          ks << p.syntax
          vs << values[p.name.capitalize.gsub('.', '__')]
        end
      end

      conditions = [ks.join(" and ")] + vs

      sql = ""
#      sql << q.columns.collect {|c| c.name}.join(', ')
      sql << " " << q.syntax
      unless vs.nil? || vs.size == 0
        sql << " and " << ActiveRecord::Base.send(:sanitize_sql_array, conditions)
      end
      sql
    end
  end
end
