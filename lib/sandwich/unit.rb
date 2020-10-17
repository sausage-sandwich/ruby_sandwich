# frozen_string_literal: true

class Unit
  UNITS = %w[g kg pound ounce
    ml l gallon quart pint cup fluid_ounce
    tablespoon teaspoon glass handful pinch pieces].freeze

  TO_METRIC_CONVERSION_RATE = {
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
    pound: TO_METRIC_CONVERSION_RATE.fetch(:pound).fetch(:quantity),
    ounce: TO_METRIC_CONVERSION_RATE.fetch(:ounce).fetch(:quantity)
  }.freeze
  GREATER_UNITS = {
    g: :kg,
    ml: :l
  }.freeze

  TO_METRIC_CONVERSION_RATE.each do |(measure, rate)|
    define_method "#{measure}_in_#{rate.fetch(:unit)}" do
      TO_METRIC_CONVERSION_RATE.fetch(measure).fetch(:quantity)
    end
  end

  ConversionError = Class.new(StandardError)

  attr_reader :quantity, :unit

  def initialize(quantity, unit)
    @quantity = BigDecimal(quantity)
    @unit = unit.to_sym
  end

  def convert_to_metric
    metric = TO_METRIC_CONVERSION_RATE[unit.to_sym]
    return self unless metric

    new_quantity = quantity * metric[:quantity]
    if new_quantity > 1000 && GREATER_UNITS[metric[:unit]]
      Unit.new(new_quantity / 1000, GREATER_UNITS[metric[:unit]])
    else
      Unit.new(new_quantity, metric[:unit])
    end
  end

  def convert_to_imperial
    return self if TO_METRIC_CONVERSION_RATE.keys.include?(unit)

    case unit
    when :kg
      Unit.new((quantity * 1000 / pound_in_g), :pound)
    when :g
      if quantity < pound_in_g
        Unit.new((quantity / ounce_in_g), :ounce)
      else
        Unit.new((quantity / pound_in_g), :pound)
      end
    when :l
      in_ml = quantity * 1000
      if in_ml < gallon_in_ml
        Unit.new((in_ml / pint_in_ml), :pint)
      else
        Unit.new((in_ml / gallon_in_ml), :gallon)
      end
    when :ml
      if quantity >= 1000
        Unit.new(quantity / 1000, :l).convert_to_imperial
      elsif quantity > pint_in_ml
        Unit.new((quantity / pint_in_ml), :pint)
      else
        Unit.new((quantity / fluid_ounce_in_ml), :fluid_ounce)
      end
    else
      self
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
