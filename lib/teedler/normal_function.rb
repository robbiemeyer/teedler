include Math

class NormalFunction
  def initialize (means, sigma)
    @means = means
    @sigma = sigma
    @n = means.size
  end

  def probability(values)
    (1/ ((2*PI)**(@n/2) * @sigma.det**0.5)) * 
      exp((-0.5 * (values - @means).covector * @sigma.inverse * (values - @means))[0])
  end

  private

  def normal_eqn(mean, sigma, x)
    sigma = 0.0001 if sigma == 0
    (1 / (sigma * sqrt(2 * PI))) * exp(-0.5 * ((x - mean)/sigma)** 2)
  end
end
