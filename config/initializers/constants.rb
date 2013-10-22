Paperclip::Attachment.default_options[:url] = ':s3_domain_url'
Paperclip::Attachment.default_options[:path] = '/:class/:attachment/:id_partition/:style/:filename'

GENRES = [
  'Pop',
  'New Music',
  'Classical',
  'Medieval',
]

SPECIALTIES = [
  'Accompaniment',
  'Performance',
]

INSTRUMENTS = [
  'Piano',
  'Guitar',
  'Drums',
  'Voice',
]

STATES = [
  {
    "name" => "California",
    "abbreviation" => "CA",
    "cities" => [
      "San Francisco",
      "Palo Alto",
      "San Diego",
    ]
  },
  
  {
    "name" => "Oregon",
    "abbreviation" => "OR",
    "cities" => [
      "Portland",
      "Eugene",
    ]
  },
]
