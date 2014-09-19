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
      open(http_url(attrs)) { |f| Hpricot::XML(f.read.force_encoding("ISO-8859-1").encode("utf-8", replace: nil)) }
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
