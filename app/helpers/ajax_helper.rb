module AjaxHelper
  
  def loading_link_to(text, path, options={})
    options[:class].blank? ? options.merge!(:class => "ajax") : options.merge!(:class => "ajax #{options[:class]}")
    link_to text, path, options
  end
  
end
