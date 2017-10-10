def parser_setup!
  stub_request(:head, /.*trill-static.s3.amazonaws.com*/).
    to_return(status: 200, body: '', headers: status_line_ok)

  stub_request(:get, /.*trill-static.s3.amazonaws.com*/).
    to_return(status: 200, body: '', headers: status_line_ok)

  stub_request(:get, /.*trill.me\/api\/v2\/artist\/d*/).
    to_return(status: 200, body: '', headers: {})

  create_regions_and_venues
end

def create_regions_and_venues
  region_attrs.each do |_region_attrs|
    venue_key = _region_attrs.delete(:venue_resource_key)

    region = Region.find_by(resource_key: _region_attrs[:resource_key]) ||
             create(:region, _region_attrs)

    Venue.find_by(resource_key: venue_key) ||
      create(:venue, resource_key: venue_key,
                     region: region, address: 'TBD')
   end
end

def region_attrs
  [{ name: 'Boston',
     code: 'BOS',
     time_zone: 'America/New_York',
     resource_key: TRILL_TONIGHT_REGION_KEY_BOS,
     venue_resource_key: TRILL_TONIGHT_VENUE_KEY_BOS },
   { name: 'Dallas',
     code: 'DFW',
     time_zone: 'America/Chicago',
     resource_key: TRILL_TONIGHT_REGION_KEY_DFW,
     venue_resource_key: TRILL_TONIGHT_VENUE_KEY_DFW },
   { name: 'Los Angeles',
     code: 'LA',
     time_zone: 'America/Los_Angeles',
     resource_key: TRILL_TONIGHT_REGION_KEY_LA,
     venue_resource_key: TRILL_TONIGHT_VENUE_KEY_LA },
   { name: 'San Francisco',
     code: 'SF',
     time_zone: 'America/Los_Angeles',
     resource_key: TRILL_TONIGHT_REGION_KEY_SF,
     venue_resource_key: TRILL_TONIGHT_VENUE_KEY_SF }]
end

def status_line_ok
  { 'Status-Line' => "HTTP/1.0 200 OK\r\n" }
end
