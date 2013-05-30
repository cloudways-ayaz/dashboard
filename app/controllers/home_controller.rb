

class HomeController < ApplicationController
  def index
      json_response = {:hello => "Hello there", :status => :OK}
#      respond_to do |format|
#          format.json { render :json => json_response }
#      end
      render :json => json_response

      #mc = rpcclient('service')
  end


end
