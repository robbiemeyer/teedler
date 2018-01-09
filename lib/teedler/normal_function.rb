include Math

class NormalFunction
  def initialize (means, sigma)
    @means = means
    @sigma = sigma
    @sigma_det = sigma.det
    @sigma_inv = sigma.inverse
    @n = means.size
  end

  def probability(values)
    (1/ ((2*PI)**(@n/2) * @sigma_det**0.5)) * 
      exp((-0.5 * (values - @means).covector * @sigma_inv * (values - @means))[0])
  end

end
