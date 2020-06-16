# frozen_string_literal: true

require 'i18n'

I18n.load_path << Dir[File.expand_path('apps/web/config/locales') + '/*.yml']
I18n.config.available_locales = %i[en ru]
I18n.default_locale = :ru

I18n::Backend::Simple.include(I18n::Backend::Pluralization)
I18n.backend.store_translations :ru, i18n: {
  plural: {
    rule: lambda do |n|
      if n.zero?
        :zero
      elsif n == 1
        :one
      elsif n <= 4
        :few
      else
        :other
      end
    end
  }
}
