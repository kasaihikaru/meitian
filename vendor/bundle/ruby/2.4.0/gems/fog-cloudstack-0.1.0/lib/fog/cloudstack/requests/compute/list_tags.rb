module Fog
  module Cloudstack
    class Compute

      class Real
        # List resource tag(s)
        #
        # {CloudStack API Reference}[http://cloudstack.apache.org/docs/api/apidocs-4.4/root_admin/listTags.html]
        def list_tags(*args)
          options = {}
          if args[0].is_a? Hash
            options = args[0]
            options.merge!('command' => 'listTags') 
          else
            options.merge!('command' => 'listTags')
          end
          request(options)
        end
      end

    end
  end
end

