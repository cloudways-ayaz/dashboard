
require 'mcollective'
include MCollective::RPC

include ServiceHelper

class ServiceController < ApplicationController
    http_basic_authenticate_with :name => "cloudways-dev-api", :password => "cloudways123+"
    before_filter :init

    def init 
        @params_verifier = ParamsVerifier.new()
        @service_name = nil
        @customer_number = nil
        @response = {:status => 0, :msg => ""}
        @is_clean = true
    end

    def check_params
        @is_clean = false
        @service_name = params[:service_name]
        @customer_number = params[:customer_number]

        if @service_name.nil?
            @response[:status] = -1
            @response[:msg] = "Service name parameter missing."
            return @response
        end

        if @customer_number.nil?
            @response[:status] = -1
            @response[:msg] = "Customer number parameter missing."
            return @response
        end

        @service_name = @params_verifier.get_service(@service_name)
        if @service_name.nil?
            @response[:status] = -1
            @response[:msg] = "Incorrect service name provided."
            return @response
        end

        @customer_number = @params_verifier.get_customer_number(@customer_number)
        if @customer_number.nil?
            @response[:status] = -1
            @response[:msg] = "Incorrect customer number provided."
            return @response
        end

        @is_clean = true
        @response
    end


    def status
        @response = check_params
        unless @is_clean
            return render :json => @response
        end

        begin
            rpc_client = rpcclient('service')
            rpc_client.verbose = false
            unless @customer_number.nil?
                rpc_client.fact_filter "cloudways_customer", @customer_number
            end
            rpc_response = rpc_client.status(:service => @service_name)
            @response = rpc_response
        rescue Exception => e
            @response[:status] = -2
            @response[:msg] = "Server error: #{e}"
        end

        render :json => @response
    end


    def start
        @response = check_params
        unless @is_clean
            return render :json => @response
        end

        begin
            rpc_client = rpcclient('service')
            rpc_client.verbose = false
            unless @customer_number.nil?
                rpc_client.fact_filter "cloudways_customer", @customer_number
            end
            rpc_response = rpc_client.start(:service => @service_name)
            @response = rpc_response
        rescue Exception => e
            @response[:status] = -2
            @response[:msg] = "API error: #{e}"
        end

        render :json => @response
    end

    def stop
        @response = check_params
        unless @is_clean
            return render :json => @response
        end

        begin
            rpc_client = rpcclient('service')
            rpc_client.verbose = false
            unless @customer_number.nil?
                rpc_client.fact_filter "cloudways_customer", @customer_number
            end
            rpc_response = rpc_client.stop(:service => @service_name)
            @response = rpc_response
        rescue Exception => e
            @response[:status] = -2
            @response[:msg] = "API error: #{e}"
        end

        render :json => @response
    end

    def restart
        @response = check_params
        unless @is_clean
            return render :json => @response
        end

        begin
            rpc_client = rpcclient('service')
            rpc_client.verbose = false
            unless @customer_number.nil?
                rpc_client.fact_filter "cloudways_customer", @customer_number
            end
            rpc_response = rpc_client.restart(:service => @service_name)
            @response = rpc_response
        rescue Exception => e
            @response[:status] = -2
            @response[:msg] = "API error: #{e}"
        end

        render :json => @response
    end
end
