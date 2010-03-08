module RoleHelper
  def get_entry(role_id, feature_id)
    name = "entry[#{role_id}-#{feature_id}]"
    entry = Entry.find_by_feature_id_and_role_id(feature_id, role_id)
    color = "#f66"
    unless entry.nil?
      color = "#9f9"
      checked = "checked=\"checked\""
    end
    return "<span style=\"background: #{color};\"><input name=\"#{name}\"
                  type=\"checkbox\" #{checked}></span>"
  end
end
