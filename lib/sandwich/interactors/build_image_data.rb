# frozen_string_literal: true

require 'hanami/interactor'

class BuildImageData
  include Hanami::Interactor

  expose :image_data

  def call(file)
    upload = image_uploader.upload(file)
    attacher = ImageUploader::Attacher.from_data(upload.data)
    attacher.create_derivatives

    @image_data = attacher.data
  end

  private

  def image_uploader
    ImageUploader.new(:store)
  end
end
