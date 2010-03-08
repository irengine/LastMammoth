module QueryHelper
  def build_tree_data
    group_list = []

    # replace current group with root group
    Group.root.full_set().each do |group|
      group_list.insert(-1,
        "#{group.lv / 2}, \"<a href=\\\"#\\\" onclick=\\\"listGroup('#{group.id}'); return false;\\\">#{group.name}</a>\""
      ) unless group.lv.nil?
    end

    group_list.join(',')
  end

  def remote_url_for_group()
    remote_function(:url => { :action => "list", :id => -1}, :update => "main").gsub(/-1'/, "' + id")
  end
end
