# frozen_string_literal: true

require_relative '../../../config/initializers/shrine'
require 'image_processing/mini_magick'

class ImageUploader < Shrine
  plugin :processing
  plugin :validation_helpers

  Attacher.validate do
    validate_extension_inclusion %w[jpg jpeg png].freeze
    validate_max_width 2000
    validate_max_height 2000
  end

  Attacher.derivatives do |original|
    pipeline = ImageProcessing::MiniMagick.
      source(original).
      convert('jpg')

    {
      large: pipeline.resize_to_fill!(800, 600),
      thumb: pipeline.resize_to_fill!(400, 300)
    }
  end
end
