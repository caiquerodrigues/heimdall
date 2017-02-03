module Heimdall
  class App
    module ResponseHelper
      def render_message message
        Oj.dump(message: message)
      end
    end

    helpers ResponseHelper
  end
end
