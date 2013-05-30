require 'mcollective'
include MCollective::RPC

class ServiceController < ApplicationController
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
        render :json => response
    end

    def stop
        response = {}
        render :json => response
    end

    def restart
        response = {}
        render :josn => response
    end
end

