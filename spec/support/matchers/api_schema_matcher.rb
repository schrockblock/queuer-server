RSpec::Matchers.define :match_response_schema do |schema|
  match do |response|
    schema_directory = "#{Dir.pwd}/spec/support/api/v1/schemas"
    schema_path = "#{schema_directory}/#{schema}.json"
    JSON::Validator.validate!(schema_path, response.body)
  end
end

RSpec::Matchers.define :strictly_match_response_schema do |schema|
  match do |response|
    schema_directory = "#{Dir.pwd}/spec/support/api/v1/schemas"
    schema_path = "#{schema_directory}/#{schema}.json"
    JSON::Validator.validate!(schema_path, response.body, strict: true)
  end
end
