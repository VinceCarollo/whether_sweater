class ApplicationController < ActionController::Base
  def render_four_oh_four
    render :file => 'public/404.html', :status => :not_found, :layout => false
  end
end
