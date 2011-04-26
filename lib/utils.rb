module Utils
  
  def redirect_back_or path
    uri = params[:return_to].blank? ? path : params[:return_to]
    redirect_to uri
  end
  
  def array_from_links_in_string(string)
    return [] if string.blank?
    
    regex = %r{ ( https?:// | www\. ) [^\s<]+ }x
    links = []
    
    string.gsub(regex) do
      links << $&
    end
    
    links
  end
  
end
