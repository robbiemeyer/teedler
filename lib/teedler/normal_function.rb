include Math

class NormalFunction
  def initialize (means, sigma2s)
    @means = means
    @sigma2s = sigma2s
  end

  private

  def normal_eqn(mean, sigma, x)
    (1 / (sigma * sqrt(2 * PI))) * exp(-0.5 * ((x - mean)/sigma)** 2)
  end
end
