class ::Integer

  def to_u(unit = :GB, num = self) 
    case unit
    when :MB
      num /= 1024
    when :GB
      2.times do
        num /= 1024
      end
      num
    when :TB 
      3.times do
        num /= 1024
      end
      num
    end
  end

  def to_h(unit = :GB, num = self)
    "#{self.to_u(unit, num)} #{unit.to_s}"  
  end
end
