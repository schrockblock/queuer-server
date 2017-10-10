# overrides the default matcher provided with paper_trail:
# https://github.com/airblade/paper_trail/blob/74d8e69b5726e754c846879cc8dba445f962fa28/lib/paper_trail/frameworks/rspec.rb#L26

RSpec::Matchers.define :have_a_version_with do |attributes|
  match { |actual| actual.versions.where_object_changes(attributes).any? }
end
