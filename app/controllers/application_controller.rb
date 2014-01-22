class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?
  after_filter :store_location


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
      if response.empty?
        "Manhattan, NY, USA"
      else
        response.first.city
      end
    else
      request.location.city
    end
  end

  def prepare_hash_for_map
   @hash = Gmaps4rails.build_markers(@users) do |user, marker|
     marker.lat user.location.latitude
     marker.lng user.location.longitude
     marker.infowindow render_to_string(:partial => '/layouts/partials/infowindow', :locals => { :user => user})
     marker.picture({
        :url     => user.instrxps.first.instrument.photo.url,
        :width   => 30,
        :height  => 30,
        })
   end
  end


  def store_location
    # store last url - this is needed for post-login redirect to whatever the user last visited.
    if (request.fullpath != "/users/sign_in" &&
        request.fullpath != "/users/sign_up" &&
        request.fullpath != "/users/password" &&
        !request.xhr?) # don't store ajax calls
      session[:previous_url] = request.fullpath 
    end
  end

  def after_sign_in_path_for(resource)
    session[:previous_url] || root_path
  end

  

end
