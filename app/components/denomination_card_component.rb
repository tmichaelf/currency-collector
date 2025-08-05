class DenominationCardComponent < ViewComponent::Base
  def initialize(denomination:)
    @denomination = denomination
  end

  private

  attr_reader :denomination
end 