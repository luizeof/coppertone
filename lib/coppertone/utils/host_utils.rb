require 'addressable/idna'

module Coppertone
  module Utils
    # A utility class that includes methods for working with
    # data about the host.
    class HostUtils
      def self.hostname
        @hostname ||=
          begin
            Socket.gethostbyname(Socket.gethostname).first
          rescue SocketError
            Socket.gethostname
          end
      end

      def self.clear_hostname
        @hostname = nil
      end
    end
  end
end
