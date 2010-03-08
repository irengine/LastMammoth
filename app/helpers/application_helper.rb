# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def page_title
    controller.controller_name + '_' + controller.action_name
  end
  
  def tl(s)
    s = s.to_s if s.kind_of?(Symbol)
    st = controller.controller_name.singularize.capitalize + ".human_attribute_name(s)"
    eval(st)
  end

    def photo_for(employee, size = :medium)
    if employee.photo
      image_tag(employee.photo.public_filename, :alt => employee.name, :size => "144x192")
    else
      image_tag("blank-photo-#{size}.png")
    end
  end
end
