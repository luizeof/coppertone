module Coppertone
  class Mechanism  # rubocop:disable Style/Documentation
    class DomainSpecRequired < DomainSpecMechanism
      def self.create(attributes)
        new(attributes)
      end

      def initialize(attributes)
        raw_domain_spec = trim_domain_spec(attributes)
        fail InvalidMechanismError if raw_domain_spec.blank?
        @domain_spec = Coppertone::DomainSpec.new(raw_domain_spec)
      rescue Coppertone::MacroStringParsingError
        raise Coppertone::InvalidMechanismError
      end

      def match?(macro_context, request_context)
        request_context.register_dns_lookup_term
        target_name =
          target_name_from_domain_spec(macro_context, request_context)
        if target_name
          match_target_name(macro_context, request_context, target_name)
        else
          handle_invalid_domain(macro_context, request_context)
        end
      end

      def handle_invalid_domain(_macro_context, _options)
        fail RecordParsingError
      end

      def ==(other)
        return false unless other.instance_of? self.class
        domain_spec == other.domain_spec
      end
    end
  end
end
