class ApplicationController < ActionController::Base
  def active_menu?(name)
    name == params[:controller] ? "active" : ""
  end
  helper_method :active_menu?
end
