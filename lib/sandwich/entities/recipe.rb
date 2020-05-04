# frozen_string_literal: true

class Recipe < Hanami::Entity
  def nutrition_facts
    (nutrition_facts_per_quantity / quantity_in_grams) * 100
  end

  def nutrition_facts_per_quantity
    recipe_ingredients.
      map(&:nutrition_facts_per_quantity).
      inject(&:+)
  end

  def quantity_in_grams
    recipe_ingredients.map(&:quantity_in_grams).inject(&:+)
  end

  def image_url(version = nil)
    version ? image_attacher.url(version.to_sym) : image_attacher.url
  end

  def image
    image_attacher.file
  end

  private

  def image_attacher
    ImageUploader::Attacher.from_model(self, :image)
  end
end
