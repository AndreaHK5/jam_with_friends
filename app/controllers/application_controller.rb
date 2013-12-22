class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?



  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
  end

  def request_ip
    if Rails.env.development? 
       response = HTTParty.get('http://api.hostip.info/get_html.php')
       ip = response.split("\n")
       ip.last.gsub /IP:\s+/, ''      
     else
       request.remote_ip
     end 
  end

  def current_location
    if Rails.env.development?
      ip = request_ip
      response = Geocoder.search(ip)
      response.first.city
    else
      request.location
    end
  end

  def prepare_hash_for_map
   @hash = Gmaps4rails.build_markers(@users) do |user, marker|
     marker.lat user.location.latitude
     marker.lng user.location.longitude
     marker.infowindow render_to_string(:partial => '/layouts/partials/infowindow', :locals => { :user => user})
   end
  end

end
