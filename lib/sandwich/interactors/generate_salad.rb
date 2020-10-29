# frozen_string_literal: true

require 'hanami/interactor'

class GenerateSalad
  include Hanami::Interactor

  INGREDIENTS = {
    crunchy: [
      'Тертая морковь',
      'Болгарский перец',
      'Огурцы',
      'Редис',
      'Свежая свекла',
      'Белокочанная капуста',
      'Зелень (базилик, петрушка, кинза)',
      'Листья салата (айсберг, руккола, шпинат, ромейн)'
    ],
    sweet_or_sour: [
      'Яблоко',
      'Помидоры',
      'Кукуруза',
      'Манго',
      'Клюква',
      'Спелая груша',
      'Гранат',
      'Изюм'
    ],
    spicy: [
      'Оливки',
      'Консервированные корнишоны',
      'Квашеная капуста',
      'Капуста кимчи',
      'Семена (кунжут, подсолнечник, тыква, лен)',
      'Сыр с плесенью',
      'Пармезан',
      'Вяленые томаты',
      'Орехи'
    ],
    protein: [
      'Тунец',
      'Курица или индейка',
      'Креветки',
      'Фасоль, нут или чечевица',
      'Лосось слабосоленый или на гриле',
      'Яйца',
      'Мягкий сыр (Адыгейский, фета, тофу)',
      'Соевая спаржа'
    ]
  }.freeze

  expose :ingredients

  def call(categories: %i[crunchy sweet_or_sour spicy protein])
    @ingredients = INGREDIENTS.values_at(*categories).map(&:sample)
  end
end
