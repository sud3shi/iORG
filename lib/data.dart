import 'dart:typed_data' show Uint8List;

final Uint8List sampleSignature = Uint8List.fromList(<int>[
  137,
  80,
  78,
  71,
  13,
  10,
  26,
  10,
  0,
  0,
  0,
  13,
  73,
  72,
  68,
  82,
  0,
  0,
  0,
  180,
  0,
  0,
  0,
  124,
  8,
  6,
  0,
  0,
  0,
  192,
  118,
  154,
  235,
  0,
  0,
  0,
  1,
  115,
  82,
  71,
  66,
  0,
  174,
  206,
  28,
  233,
  0,
  0,
  0,
  4,
  115,
  66,
  73,
  84,
  8,
  8,
  8,
  8,
  124,
  8,
  100,
  136,
  0,
  0,
  9,
  183,
  73,
  68,
  65,
  84,
  120,
  156,
  237,
  157,
  125,
  144,
  85,
  117,
  25,
  199,
  63,
  58,
  235,
  75,
  177,
  6,
  145,
  202,
  203,
  20,
  88,
  232,
  136,
  41,
  229,
  176,
  53,
  37,
  53,
  4,
  149,
  235,
  40,
  102,
  163,
  134,
  35,
  177,
  25,
  89,
  127,
  244,
  134,
  19,
  51,
  53,
  67,
  127,
  84,
  107,
  127,
  148,
  134,
  205,
  48,
  49,
  196,
  52,
  141,
  99,
  45,
  194,
  202,
  154,
  47,
  5,
  54,
  105,
  34,
  23,
  212,
  0,
  87,
  94,
  36,
  149,
  74,
  169,
  68,
  11,
  21,
  208,
  114,
  3,
  195,
  13,
  110,
  127,
  60,
  231,
  120,
  126,
  231,
  238,
  221,
  101,
  119,
  207,
  221,
  251,
  220,
  115,
  239,
  247,
  51,
  115,
  230,
  252,
  238,
  238,
  57,
  123,
  191,
  247,
  220,
  239,
  62,
  231,
  57,
  191,
  87,
  16,
  66,
  8,
  33,
  106,
  157,
  22,
  160,
  201,
  91,
  132,
  16,
  149,
  224,
  108,
  160,
  8,
  244,
  2,
  221,
  206,
  90,
  68,
  6,
  78,
  244,
  22,
  80,
  35,
  92,
  24,
  237,
  155,
  128,
  131,
  158,
  66,
  68,
  54,
  100,
  104,
  227,
  194,
  160,
  188,
  195,
  137,
  80,
  78,
  71,
  13,
  10,
  26,
  10,
  0,
  0,
  0,
  13,
  73,
  72,
  68,
  82,
  0,
  0,
  0,
  173,
  0,
  0,
  0,
  136,
  8,
  6,
  0,
  0,
  0,
  149,
  206,
  107,
  198,
  0,
  0,
  0,
  1,
  115,
  82,
  71,
  66,
  0,
  174,
  206,
  28,
  233,
  0,
  0,
  0,
  4,
  115,
  66,
  73,
  84,
  8,
  8,
  8,
  8,
  124,
  8,
  100,
  136,
  0,
  0,
  15,
  171,
  73,
  68,
  65,
  84,
  120,
  156,
  237,
  157,
  121,
  180,
  28,
  85,
  17,
  135,
  63,
  12,
  106,
  88,
  84,
  8,
  200,
  34,
  89,
  192,
  128,
  1,
  21,
  197,
  163,
  28,
  77,
  112,
  129,
  160,
  70,
  68,
  209,
  67,
  0,
  23,
  2,
  4,
  48,
  30,
  81,
  31,
  238,
  122,
  112,
  193,
  135,
  108,
  42,
  168,
  8,
  10,
  7,
  148,
  205,
  16,
  162,
  4,
  149,
  24,
  64,
  194,
  146,
  188,
  23,
  80,
  32,
  172,
  81,
  19,
  21,
  89,
  18,
  131,
  241,
  5,
  92,
  192,
  72,
  16,
  73,
  50,
  254,
  241,
  235,
  107,
  223,
  238,
  153,
  233,
  183,
  76,
  79,
  223,
  238,
  153,
  250,
  206,
  233,
  243,
  186,
  231,
  205,
  116,
  215,
  204,
  212,
  84,
  215,
  173,
  170,
  91,
  23,
  12,
  195,
  48,
  140,
  92,
  217,
  28,
  184,
  21,
  168,
  1,
  215,
  69,
  199,
  134,
  81,
  106,
  230,
  33,
  133,
  117,
  219,
  167,
  76,
  107,
  141,
  178,
  178,
  53,
  112,
  13,
  112,
  96,
  104,
  65,
  12,
  99,
  40,
  76,
  7,
  214,
  32,
  203,
  186,
  152,
  216,
  202,
  254,
  10,
  115,
  15,
  140,
  146,
  177,
  61,
  24,
]);

class Contact {
  final String name;
  final String email;
  final String imageUrl;

  const Contact(this.name, this.email, this.imageUrl);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Contact &&
          runtimeType == other.runtimeType &&
          name == other.name;

  @override
  int get hashCode => name.hashCode;

  @override
  String toString() {
    return name;
  }
}

const allCountries = [
  'Afghanistan',
  'Albania',
  'Algeria',
  'American Samoa',
  'Andorra',
  'Angola',
  'Anguilla',
  'Antarctica',
  'Antigua and Barbuda',
  'Argentina',
  'Armenia',
  'Aruba',
  'Australia',
  'Austria',
  'Azerbaijan',
  'Bahamas',
  'Bahrain',
  'Bangladesh',
  'Barbados',
  'Belarus',
  'Belgium',
  'Belize',
  'Benin',
  'Bermuda',
  'Bhutan',
  'Bolivia',
  'Bosnia and Herzegowina',
  'Botswana',
  'Bouvet Island',
  'Brazil',
  'British Indian Ocean Territory',
  'Brunei Darussalam',
  'Bulgaria',
  'Burkina Faso',
  'Burundi',
  'Cambodia',
  'Cameroon',
  'Canada',
  'Cape Verde',
  'Cayman Islands',
  'Central African Republic',
  'Chad',
  'Chile',
  'China',
  'Christmas Island',
  'Cocos (Keeling) Islands',
  'Colombia',
  'Comoros',
  'Congo',
  'Congo, the Democratic Republic of the',
  'Cook Islands',
  'Costa Rica',
  "Cote d'Ivoire",
  'Croatia (Hrvatska)',
  'Cuba',
  'Cyprus',
  'Czech Republic',
  'Denmark',
  'Djibouti',
  'Dominica',
  'Dominican Republic',
  'East Timor',
  'Ecuador',
  'Egypt',
  'El Salvador',
  'Equatorial Guinea',
  'Eritrea',
  'Estonia',
  'Ethiopia',
  'Falkland Islands (Malvinas)',
  'Faroe Islands',
  'Fiji',
  'Finland',
  'France',
  'France Metropolitan',
  'French Guiana',
  'French Polynesia',
  'French Southern Territories',
  'Gabon',
  'Gambia',
  'Georgia',
  'Germany',
  'Ghana',
  'Gibraltar',
  'Greece',
  'Greenland',
  'Grenada',
  'Guadeloupe',
  'Guam',
  'Guatemala',
  'Guinea',
  'Guinea-Bissau',
  'Guyana',
  'Haiti',
  'Heard and Mc Donald Islands',
  'Holy See (Vatican City State)',
  'Honduras',
  'Hong Kong',
  'Hungary',
  'Iceland',
  'India',
  'Indonesia',
  'Iran (Islamic Republic of)',
  'Iraq',
  'Ireland',
  'Israel',
  'Italy',
  'Jamaica',
  'Japan',
  'Jordan',
  'Kazakhstan',
  'Kenya',
  'Kiribati',
  "Korea, Democratic People's Republic of",
  'Korea, Republic of',
  'Kuwait',
  'Kyrgyzstan',
  "Lao, People's Democratic Republic",
  'Latvia',
  'Lebanon',
  'Lesotho',
  'Liberia',
  'Libyan Arab Jamahiriya',
  'Liechtenstein',
  'Lithuania',
  'Luxembourg',
  'Macau',
  'Macedonia, The Former Yugoslav Republic of',
  'Madagascar',
  'Malawi',
  'Malaysia',
  'Maldives',
  'Mali',
  'Malta',
  'Marshall Islands',
  'Martinique',
  'Mauritania',
  'Mauritius',
  'Mayotte',
  'Mexico',
  'Micronesia, Federated States of',
  'Moldova, Republic of',
  'Monaco',
  'Mongolia',
  'Montserrat',
  'Morocco',
  'Mozambique',
  'Myanmar',
  'Namibia',
  'Nauru',
  'Nepal',
  'Netherlands',
  'Netherlands Antilles',
  'New Caledonia',
  'New Zealand',
  'Nicaragua',
  'Niger',
  'Nigeria',
  'Niue',
  'Norfolk Island',
  'Northern Mariana Islands',
  'Norway',
  'Oman',
  'Pakistan',
  'Palau',
  'Panama',
  'Papua New Guinea',
  'Paraguay',
  'Peru',
  'Philippines',
  'Pitcairn',
  'Poland',
  'Portugal',
  'Puerto Rico',
  'Qatar',
  'Reunion',
  'Romania',
  'Russian Federation',
  'Rwanda',
  'Saint Kitts and Nevis',
  'Saint Lucia',
  'Saint Vincent and the Grenadines',
  'Samoa',
  'San Marino',
  'Sao Tome and Principe',
  'Saudi Arabia',
  'Senegal',
  'Seychelles',
  'Sierra Leone',
  'Singapore',
  'Slovakia (Slovak Republic)',
  'Slovenia',
  'Solomon Islands',
  'Somalia',
  'South Africa',
  'South Georgia and the South Sandwich Islands',
  'Spain',
  'Sri Lanka',
  'St. Helena',
  'St. Pierre and Miquelon',
  'Sudan',
  'Suriname',
  'Svalbard and Jan Mayen Islands',
  'Swaziland',
  'Sweden',
  'Switzerland',
  'Syrian Arab Republic',
  'Taiwan, Province of China',
  'Tajikistan',
  'Tanzania, United Republic of',
  'Thailand',
  'Togo',
  'Tokelau',
  'Tonga',
  'Trinidad and Tobago',
  'Tunisia',
  'Turkey',
  'Turkmenistan',
  'Turks and Caicos Islands',
  'Tuvalu',
  'Uganda',
  'Ukraine',
  'United Arab Emirates',
  'United Kingdom',
  'United States',
  'United States Minor Outlying Islands',
  'Uruguay',
  'Uzbekistan',
  'Vanuatu',
  'Venezuela',
  'Vietnam',
  'Virgin Islands (British)',
  'Virgin Islands (U.S.)',
  'Wallis and Futuna Islands',
  'Western Sahara',
  'Yemen',
  'Yugoslavia',
  'Zambia',
  'Zimbabwe'
];

const contacts = <Contact>[
  Contact('Andrew', 'stock@man.com',
      'https://d2gg9evh47fn9z.cloudfront.net/800px_COLOURBOX4057996.jpg'),
  Contact('Paul', 'paul@google.com',
      'https://mbtskoudsalg.com/images/person-stock-image-png.png'),
  Contact('Fred', 'fred@google.com',
      'https://media.istockphoto.com/photos/feeling-great-about-my-corporate-choices-picture-id507296326'),
  Contact('Brian', 'brian@flutter.io',
      'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
  Contact('John', 'john@flutter.io',
      'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
  Contact('Thomas', 'thomas@flutter.io',
      'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
  Contact('Nelly', 'nelly@flutter.io',
      'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
  Contact('Marie', 'marie@flutter.io',
      'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
  Contact('Charlie', 'charlie@flutter.io',
      'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
  Contact('Diana', 'diana@flutter.io',
      'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
  Contact('Ernie', 'ernie@flutter.io',
      'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
  Contact('Gina', 'fred@flutter.io',
      'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
];