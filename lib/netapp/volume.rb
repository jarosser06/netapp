class NetApp
  class Volume
    attr_accessor :name, :used, :free, :total 
    
    def initialize(name, used, free, total)
      @name = name 
      @used = used
      @free = free
      @total = total
    end

    def percentage_used
      (@used.to_f / @total.to_f * 100).round(3)
    end
  end
end
