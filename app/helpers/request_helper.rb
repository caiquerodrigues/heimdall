module Heimdall
  class App
    module RequestHelper
      def payload(namespace)
        Oj.load(request.body.read)[namespace] rescue params[namespace]
      end
    end

    helpers RequestHelper
  end
end
