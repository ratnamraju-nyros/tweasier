class PagesController < ApplicationController
  
  def index
    redirect_to page_path("about")
  end
  
  def show
    page = params[:id] || "about"
    
    unless page.present? and File.exists?("#{RAILS_ROOT}/app/views/pages/_#{page}.html.haml")
      render_error("404")
      return
    end
    
    render :partial => "pages/#{page}", :layout => true
  end
  
end
