def encoded_picture
  picture = fixture_file_upload(Rails.root.join('spec', 'fixtures', 'photos', 'test.jpg'), 'image/jpg')
  Base64.encode64(File.read(picture.tempfile))
end
