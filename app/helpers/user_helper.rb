module UserHelper
  def get_permission(user_id, role_id)
    name = "permission[#{user_id}-#{role_id}]"
    permission = Permission.find_by_role_id_and_user_id(role_id, user_id)
    color = "#f66"
    unless permission.nil?
      color = "#9f9"
      checked = "checked=\"checked\""
    end
    return "<span style=\"background: #{color};\"><input name=\"#{name}\"
                  type=\"checkbox\" #{checked}></span>"
  end
end
