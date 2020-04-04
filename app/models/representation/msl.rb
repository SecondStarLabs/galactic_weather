class Representation::Msl < Representation
  def election_day
    Time.now
  end

  def min_temp
    mt = self.min_temp
    mt.to_i
  end

  def combo
    [self.min_temp,
     self.max_temp].join(' ')
  end

end
