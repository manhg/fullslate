module Fullslate
  class Api
    include HTTParty

    class << self
      def config_updated
        base_uri Fullslate.api_uri
      end

      def employees
        employees_array = Array.new

        get('/employees', query: Fullslate.url_params).each do |employee_json|
          employees_array << Fullslate::Employee.new(employee_json)
        end

        employees_array
      end

      def employee(id)
        json = get("/employees/#{id}", query: Fullslate.url_params)
        Fullslate::Employee.new(json)
      end

      def services
        services_array = Array.new

        get('/services', query: Fullslate.url_params).each do |services_json|
          services_array << Fullslate::Service.new(services_json)
        end

        services_array
      end

      def clients
        params = Fullslate.url_params.merge!( { include: 'emails,phone_numbers,addresses,links' } )
        clients_array = Array.new

        get('/clients', query: params).each do |clients_json|
          clients_array << Fullslate::Client.new(clients_json)
        end

        clients_array
      end

    end
  end
end

