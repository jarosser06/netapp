require 'snmp'

require_relative 'netapp/volume'
require_relative 'netapp/monkey_patches/integer'
require_relative 'netapp/query'

class NetApp
  include NetApp::Query
  attr_accessor :host, :community, :options
  def initialize(host, community = "public", options = {})
    @host = host
    @community = community
    @options = options 
  end

  def volume(vol)
    recieved = fetch_vol(vol)
    NetApp::Volume.new(recieved[:name], recieved[:used], recieved[:free], recieved[:total])
  end

  def volumes
    fetch_vols.values
  end

  def failed_disks?
    if failed_disks == 0
      false 
    else
      true 
    end
  end

  def failed_disks
    fetch(["1.3.6.1.4.1.789.1.6.4.7.0"]).pop.to_i
  end
  
  def failed_power_supplies
    fetch(["1.3.6.1.4.1.789.1.2.4.4.0"]).pop.to_i
  end

  def failed_power_supply?
    if failed_power_supplies == 0
      false
    else
      true
    end
  end

  def cache_age
    fetch(["1.3.6.1.4.1.789.1.2.2.23.0"]).pop.to_i
  end

  def uptime
    fetch(["1.3.6.1.2.1.1.3.0"]).pop[/[0-9]+ days/]
  end

  def over_temperature?
    if fetch(["1.3.6.1.4.1.789.1.2.4.1.0"]).pop.to_i == 1
      false
    else
      true
    end 
  end

  def nvram_battery_status
    case fetch(["1.3.6.1.4.1.789.1.2.5.1.0"]).pop.to_i
    when 1 
      "ok"
    when 2 
      "partially discharged"
    when 3 
      "fully discharged"
    when 4 
      "not present"
    when 5
      "near end of life"
    when 6
      "at end of life"
    else
      "unknown"
    end
  end
end
