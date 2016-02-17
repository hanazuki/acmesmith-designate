require 'acmesmith/challenge_responders/base'

require 'yao/designate'

module Acmesmith
  module ChallengeResponders
    class Designate < Base
      def support?(type)
        type == 'dns-01'
      end

      def initialize(config)
        @config = config
        config_yao(@config[:identity])
      end

      def respond(domain, challenge)
        domain = canonicalize(domain)
        find_zone(domain).records.create(
          name: [challenge.record_name, domain].join(?.),
          type: challenge.record_type,
          data: challenge.record_content,
          ttl: @config[:ttl],
        )
      end

      def cleanup(domain, challenge)
        domain = canonicalize(domain)
        zone = find_zone(domain)
        name = [challenge.record_name, domain].join(?.)
        if record = zone.records.list.find {|r| r.name == name }
          zone.records.destroy(record.id)
        end
      end

      private

      def canonicalize(domain)
        "#{domain}.".gsub(/\.{2,}/, '.')
      end

      def zones
        @zones ||= Yao::Domain.list
      end

      def find_zone(domain)
        zones.select {|z| domain =~ /(?:\A|\.)#{Regexp.escape(z.name)}\z/ }.max_by {|z| z.name.length } or
          fail "Domain #{domain} is not configured in Designate"
      end

      def config_yao(identity)
        Yao.config do
          auth_url(identity&.dig('auth_url') || ENV['OS_AUTH_URL'])
          tenant_name(identity&.dig('tenant_name') || ENV['OS_TENANT_NAME'])
          username(identity&.dig('username') || ENV['OS_USERNAME'])
          password(identity&.dig('password') || ENV['OS_PASSWORD'])
        end
      end
    end
  end
end
