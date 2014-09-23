require 'open-uri'
require 'active_support/core_ext/hash'
module DataFactory
  module Connection
    def document(attrs = {})
      if DataFactory.configuration.http
        http_connection(attrs)
      else
        ftp_connection
      end
    end

    def http_connection(attrs)
      Nokogiri::XML.parse(open(http_url(attrs)))
    end

    def ftp_connection
    end

    def http_url(attrs)
      attrs["ppaass"] = DataFactory.configuration.password
      uri = URI(DataFactory.configuration.url)
      URI::HTTP.build({host: uri.host, path: uri.path, query: attrs.to_query})
    end
  end
end
