# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{google-geo}
  s.version = "2.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Seth Thomas Rasmussen"]
  s.date = %q{2009-11-19}
  s.description = %q{A simple, elegant library for getting geocoding information from Google Maps. Very much inspired by the google-geocode gem, but completely dependency free!
}
  s.email = %q{sethrasmussen@gmail.com}
  s.extra_rdoc_files = ["CHANGELOG", "LICENSE", "README.textile", "lib/google/geo.rb", "lib/google/geo/address.rb", "lib/google/geo/address/street_view.rb", "lib/google/geo/params.rb", "lib/google/geo/parser.rb", "lib/google/geo/response.rb"]
  s.files = ["CHANGELOG", "LICENSE", "Manifest", "README.textile", "Rakefile", "google-geo.gemspec", "lib/google/geo.rb", "lib/google/geo/address.rb", "lib/google/geo/address/street_view.rb", "lib/google/geo/params.rb", "lib/google/geo/parser.rb", "lib/google/geo/response.rb", "script/test_street_view.rb", "test/fixtures/invalid_map_key.xml", "test/fixtures/missing_address.xml", "test/fixtures/reverse_locate_602.xml", "test/fixtures/reverse_locate_success.xml", "test/fixtures/server_error.xml", "test/fixtures/streetview_success.xml", "test/fixtures/success.xml", "test/fixtures/success_english.xml", "test/fixtures/success_german.xml", "test/fixtures/success_with_multiple_addresses.xml", "test/fixtures/too_many_queries.xml", "test/fixtures/unavailable_address.xml", "test/fixtures/unknown_address.xml", "test/geo_test.rb", "test/reverse_locate_test.rb", "test/test_helper.rb", "vendor/mocha-0.4.0/COPYING", "vendor/mocha-0.4.0/MIT-LICENSE", "vendor/mocha-0.4.0/README", "vendor/mocha-0.4.0/RELEASE", "vendor/mocha-0.4.0/Rakefile", "vendor/mocha-0.4.0/examples/misc.rb", "vendor/mocha-0.4.0/examples/mocha.rb", "vendor/mocha-0.4.0/examples/stubba.rb", "vendor/mocha-0.4.0/lib/mocha.rb", "vendor/mocha-0.4.0/lib/mocha/any_instance_method.rb", "vendor/mocha-0.4.0/lib/mocha/auto_verify.rb", "vendor/mocha-0.4.0/lib/mocha/central.rb", "vendor/mocha-0.4.0/lib/mocha/class_method.rb", "vendor/mocha-0.4.0/lib/mocha/expectation.rb", "vendor/mocha-0.4.0/lib/mocha/expectation_error.rb", "vendor/mocha-0.4.0/lib/mocha/infinite_range.rb", "vendor/mocha-0.4.0/lib/mocha/inspect.rb", "vendor/mocha-0.4.0/lib/mocha/instance_method.rb", "vendor/mocha-0.4.0/lib/mocha/metaclass.rb", "vendor/mocha-0.4.0/lib/mocha/mock.rb", "vendor/mocha-0.4.0/lib/mocha/mock_methods.rb", "vendor/mocha-0.4.0/lib/mocha/object.rb", "vendor/mocha-0.4.0/lib/mocha/pretty_parameters.rb", "vendor/mocha-0.4.0/lib/mocha/setup_and_teardown.rb", "vendor/mocha-0.4.0/lib/mocha/standalone.rb", "vendor/mocha-0.4.0/lib/mocha/test_case_adapter.rb", "vendor/mocha-0.4.0/lib/mocha_standalone.rb", "vendor/mocha-0.4.0/lib/stubba.rb", "vendor/mocha-0.4.0/test/active_record_test_case.rb", "vendor/mocha-0.4.0/test/all_tests.rb", "vendor/mocha-0.4.0/test/execution_point.rb", "vendor/mocha-0.4.0/test/method_definer.rb", "vendor/mocha-0.4.0/test/mocha/any_instance_method_test.rb", "vendor/mocha-0.4.0/test/mocha/auto_verify_test.rb", "vendor/mocha-0.4.0/test/mocha/central_test.rb", "vendor/mocha-0.4.0/test/mocha/class_method_test.rb", "vendor/mocha-0.4.0/test/mocha/expectation_test.rb", "vendor/mocha-0.4.0/test/mocha/infinite_range_test.rb", "vendor/mocha-0.4.0/test/mocha/inspect_test.rb", "vendor/mocha-0.4.0/test/mocha/metaclass_test.rb", "vendor/mocha-0.4.0/test/mocha/mock_methods_test.rb", "vendor/mocha-0.4.0/test/mocha/mock_test.rb", "vendor/mocha-0.4.0/test/mocha/object_test.rb", "vendor/mocha-0.4.0/test/mocha/pretty_parameters_test.rb", "vendor/mocha-0.4.0/test/mocha/setup_and_teardown_test.rb", "vendor/mocha-0.4.0/test/mocha_acceptance_test.rb", "vendor/mocha-0.4.0/test/mocha_test_result_integration_test.rb", "vendor/mocha-0.4.0/test/standalone_acceptance_test.rb", "vendor/mocha-0.4.0/test/stubba_acceptance_test.rb", "vendor/mocha-0.4.0/test/stubba_integration_test.rb", "vendor/mocha-0.4.0/test/stubba_test_result_integration_test.rb", "vendor/mocha-0.4.0/test/test_helper.rb"]
  s.homepage = %q{http://github.com/greatseth/google-geo}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Google-geo", "--main", "README.textile"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{google-geo}
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{A simple, elegant library for getting geocoding information from Google Maps. Very much inspired by the google-geocode gem, but completely dependency free!}
  s.test_files = ["test/geo_test.rb", "test/reverse_locate_test.rb", "test/test_helper.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
