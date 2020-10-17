# frozen_string_literal: true

class Unit
  UNITS = %w[g kg pound ounce
    ml l gallon quart pint cup fluid_ounce
    tablespoon teaspoon glass handful pinch pieces].freeze

  CONVERSION_RATE = {
    gallon: { quantity: 4546.09, unit: :ml },
    quart: { quantity: 1136.52, unit: :ml },
    pint: { quantity: 568.261, unit: :ml },
    fluid_ounce: { quantity: 28.4131, unit: :ml },
    pound: { quantity: 453.592, unit: :g },
    ounce: { quantity: 28.3495, unit: :g }
  }.freeze
  TO_GRAMS_CONVERSION_RATE = {
    g: 1,
    kg: 1000,
    pound: CONVERSION_RATE.fetch(:pound).fetch(:quantity),
    ounce: CONVERSION_RATE.fetch(:ounce).fetch(:quantity)
  }.freeze
  GREATER_UNITS = {
    g: :kg,
    ml: :l
  }.freeze

  ConversionError = Class.new(StandardError)

  attr_reader :quantity, :unit

  def initialize(quantity, unit)
    @quantity = BigDecimal(quantity)
    @unit = unit
  end

  def convert_to_metric
    metric = CONVERSION_RATE[unit.to_sym]
    return self unless metric

    new_quantity = quantity * metric[:quantity]
    if new_quantity > 1000 && GREATER_UNITS[metric[:unit]]
      Unit.new(new_quantity / 1000, GREATER_UNITS[metric[:unit]])
    else
      Unit.new(new_quantity, metric[:unit])
    end
  end

  def convert_to_grams
    rate = TO_GRAMS_CONVERSION_RATE.fetch(unit.to_sym, nil)
    raise ConversionError, "can't convert #{unit} to grams" unless rate

    Unit.new(quantity * rate, :g)
  end

  def humanize
    "#{quantity.truncate(2).to_s('F')} #{I18n.t(unit, scope: 'units', count: quantity.to_i)}"
  end
end
