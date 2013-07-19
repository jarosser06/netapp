require 'snmp'

class NetApp
  module Query

    BASE_VOL_OID = '1.3.6.1.4.1.789.1.5.4.1'

    def fetch_vol(name)
      results = {}

      self.fetch_vols.each do |vol_num, vol_name|
        if vol_name.include? name 
            results.merge!({ :name => name })

            details = [ BASE_VOL_OID + '.30' +".#{vol_num}", 
                        BASE_VOL_OID + '.31' +".#{vol_num}", 
                        BASE_VOL_OID + '.29' +".#{vol_num}" ]

            results.merge!({ :used => self.fetch(details)[0].to_i })
            results.merge!({ :free => self.fetch(details)[1].to_i })
            results.merge!({ :total => self.fetch(details)[2].to_i })
          break
        end
      end
      results
    end

    def fetch_vols
      vols = {}
      i = 1
      SNMP::Manager.open(:host => self.host) do |manager|
        manager.walk(BASE_VOL_OID + '.2') do |name|
          vols.merge!({i => name.value})
          i += 1
        end
      end
      vols
    end

    def fetch(oids)
      reply = []
      SNMP::Manager.open(:host => self.host) do |manager|
        reply = manager.get(oids).each_varbind.map { |vb| vb.value.to_s }
      end 
    end 
  end
end
