module Heimdall
  class App < Padrino::Application
    register Padrino::Mailer
    register Padrino::Helpers
    disable :sessions
    disable :flash
    disable :protect_from_csrf

    use Rack::Cors do
      allow do
        origins '*'
        resource '*',
          :headers => :any,
          :methods => [:get, :post, :delete, :put, :patch, :options, :head]
      end
    end
  end
end
