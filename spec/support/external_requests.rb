module ExternalRequests
  def stub_facebook_me_request(facebook_identity = build_stubbed(:facebook_identity))
    require 'webmock/rspec'
    WebMock.disable_net_connect!(allow_localhost: false)
    WebMock.stub_request(:get, "https://graph.facebook.com/me?access_token=#{facebook_identity.token}").
      to_return(body: profile_response(facebook_identity))
  end

  def stub_facebook_me_request_updated_profile(facebook_identity = create(:facebook_identity))
    WebMock.stub_request(:get, "https://graph.facebook.com/me?access_token=#{facebook_identity.token}").
      to_return(body: updated_profile_response(facebook_identity))
  end

  def stub_invalid_facebook_me_request(facebook_identity = build_stubbed(:facebook_identity))
    WebMock.stub_request(:get, "https://graph.facebook.com/me?access_token=#{facebook_identity.token}").
      to_return(body: invalid_oauth_response, status: 400)
  end

  def stub_facebook_photo_request(facebook_identity = build_stubbed(:facebook_identity))
    WebMock.stub_request(:get, "https://graph.facebook.com/v2.3/#{facebook_identity.facebook_uid}/picture?return_ssl_resources=1&type=large").
      to_return(body: '', status: 200)
  end

  def stub_set_profile_picture(facebook_identity = build_stubbed(:facebook_identity))
    allow_any_instance_of(User).to receive(:profile_picture=).
      and_return(facebook_identity.picture_url)
  end

  def profile_response(facebook_identity)
    {
      id: facebook_identity.facebook_uid,
      email: 'test@gmail.com',
      first_name: facebook_identity.first_name,
      gender: 'male',
      birthday: '03/14/1989',
      last_name: facebook_identity.last_name,
      link: "https://www.facebook.com/app_scoped_user_id/#{facebook_identity.facebook_uid}/",
      location: {
        id: '108056275889020',
        name: "Copenhagen"
      },
      locale: 'en_US',
      name: "#{facebook_identity.first_name} #{facebook_identity.last_name}",
      timezone: -4,
      updated_time: formatted_time,
      verified: true
    }.to_json
  end

  def updated_profile_response(facebook_identity)
    {
      id: facebook_identity.facebook_uid,
      email: 'test@gmail.com',
      first_name: 'MY NEW FIRST NAME',
      gender: 'male',
      birthday: '03/14/1989',
      last_name: facebook_identity.last_name,
      link: "https://www.facebook.com/app_scoped_user_id/#{facebook_identity.facebook_uid}/",
      location: {
        id: '108056275889020',
        name: "Copenhagen"
      },
      locale: 'en_US',
      name: "#{facebook_identity.first_name} #{facebook_identity.last_name}",
      timezone: -4,
      updated_time: formatted_time,
      verified: true
    }.to_json
  end

  def invalid_oauth_response
    { error:
      {
        message: 'Invalid OAuth access token.',
        type: 'OAuthException',
        code: 190
      }
    }.to_json
  end

  def formatted_time
    Time.zone.
      now.
      in_time_zone(ActiveSupport::TimeZone['UTC']).
      iso8601.
      sub('Z', '+0000')
  end
end
