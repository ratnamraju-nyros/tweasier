formats = {
  :default => "%A %d %B",
  :precise => "%A %d %B (at %H:%M%p)"
}

ActiveSupport::CoreExtensions::Time::Conversions::DATE_FORMATS.merge! formats