require 'concurrent'
require 'dry-container'
require 'pr/pin/version'
require 'pr/pin/adapter'
require 'pr/pin/error'
require 'pr/pin/repositories'
require 'pr/pin/types'

module PR
  module Pin
    LIVE_URL = 'https://api.pinpayments.com/1'.freeze
    SANDBOX_URL = 'https://test-api.pinpayments.com/1'.freeze

    extend Dry::Container::Mixin

    register(:environments, memoize: true) do
      {}
    end

    register(:default_error_handler) { |error| error }

    class << self
      def register_connection(
        identifier = :default,
        secret_key:,
        sandbox: true,
        error_handler: nil
      )
        configuration = ROM::Configuration.new(:pr_pin, {
          uri: sandbox ? SANDBOX_URL : LIVE_URL,
          secret_key: secret_key,
          error_handler: error_handler || resolve(:default_error_handler),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'User-Agent': "pr-pin:#{VERSION}"
          }
        })

        configuration.auto_registration(
          File.expand_path('pin', __dir__),
          namespace: 'PR::Pin'
        )

        environments[identifier] = ROM.container(configuration)
      end

      def environments
        resolve(:environments)
      end

      def charges(identifier = :default)
        Repositories::Charges.new(environments[identifier])
      end

      def customers(identifier = :default)
        Repositories::Customers.new(environments[identifier])
      end

      def plans(identifier = :default)
        Repositories::Plans.new(environments[identifier])
      end

      def subscriptions(identifier = :default)
        Repositories::Subscriptions.new(environments[identifier])
      end
    end
  end
end
