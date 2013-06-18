
require 'mcollective'
include MCollective::RPC

class ServiceController < ApplicationController
    http_basic_authenticate_with :name => "cloudways-dev-api", :password => "cloudways123+"

    def status
        response = {:status => 0, :msg => ""}
        service_name = params[:service_name]
        customer_number = params[:customer_number]

        if service_name.nil?
            response[:status] = -1
            response[:msg] = "Service name parameter missing."
            return :json => response
        end

        rpc_client = rpcclient('service')
        rpc_client.verbose = false
        unless customer_number.nil?
            rpc_client.fact_filter "cloudways_customer", customer_number
        end
        rpc_response = rpc_client.status(:service => service_name)
        response = rpc_response

        render :json => response
    end


    def start
        response = {}
        service_name = params[:service_name]
        customer_number = params[:customer_number]

        unless service_name.nil?
            rpc_client = rpcclient('service')
            rpc_client.verbose = false

            unless customer_number.nil? 
                rpc_client.fact_filter "cloudways_customer", customer_number
            end
            rpc_response = rpc_client.start(:service => service_name)
            response = rpc_response
        else
            response[:status] = -1
            response[:msg] = 'Service name parameter missing.'
        end

        render :json => response
    end

    def stop
        response = {}
        service_name = params[:service_name]
        customer_number = params[:customer_number]

        unless service_name.nil?
            rpc_client = rpcclient('service')
            rpc_client.verbose = false

            unless customer_number.nil? 
                rpc_client.fact_filter "cloudways_customer", customer_number
            end
            rpc_response = rpc_client.stop(:service => service_name)
            response = rpc_response
        else
            response[:status] = -1
            response[:msg] = 'Service name parameter missing.'
        end

        render :json => response
    end

    def restart
        response = {}
        service_name = params[:service_name]
        customer_number = params[:customer_number]

        unless service_name.nil?
            rpc_client = rpcclient('service')
            rpc_client.verbose = false

            unless customer_number.nil? 
                rpc_client.fact_filter "cloudways_customer", customer_number
            end
            rpc_response = rpc_client.restart(:service => service_name)
            response = rpc_response
        else
            response[:status] = -1
            response[:msg] = 'Service name parameter missing.'
        end

        render :json => response
    end

    #  private
    #  def perform_action(action)
    #    service_name = params[:service_name]
    #    customer_number = params[:customer_number]
    #
    #    rpc_resposne = {}
    #
    #    unless service_name.nil?
    #      rpc_client = rpcclient('service')
    #      rpc_client.verbose = false
    #
    #      unless customer_number.nil? 
    #        rpc_client.fact_filter "cloudways_customer", customer_number
    #      end
    #
    #      case action
    #      when "start"
    #        rpc_response = rpc_client.start(:service => service_name)
    #      when "stop"
    #        rpc_response = rpc_client.stop(:service => service_name)
    #      when "restart"
    #        rpc_response = rpc_client.restart(:service => service_name)
    #      when "status"
    #        rpc_response = rpc_client.status(:service => service_name)
    #      else
    #        rpc_response = {}
    #      end
    #    else
    #      rpc_response[:status] = -1
    #      rpc_response[:msg] = 'Service name parameter missing.'
    #    end
    #
    #    return rpc_response
    #  end
    #  #private_class_method :perform_action
end
