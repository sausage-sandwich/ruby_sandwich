# frozen_string_literal: true

require 'shrine'
require 'shrine/storage/file_system'

Shrine.storages = {
  cache: Shrine::Storage::FileSystem.new('public', prefix: 'uploads/cache'), # temporary
  store: Shrine::Storage::FileSystem.new('public', prefix: 'uploads')        # permanent
}

Shrine.plugin :sequel
Shrine.plugin :cached_attachment_data
Shrine.plugin :rack_file
Shrine.plugin :derivatives
Shrine.plugin :validation
Shrine.plugin :remove_invalid
