/// Country data model for Flutter
class Country {
  final String code;
  final String label;
  final String phone;
  final bool suggested;

  const Country({
    required this.code,
    required this.label,
    required this.phone,
    this.suggested = false,
  });

  /// Convert from JSON
  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      code: json['code'] as String,
      label: json['label'] as String,
      phone: json['phone'] as String,
      suggested: json['suggested'] as bool? ?? false,
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'label': label,
      'phone': phone,
      if (suggested) 'suggested': suggested,
    };
  }

  @override
  String toString() => '$label ($code) +$phone';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Country && other.code == code;
  }

  @override
  int get hashCode => code.hashCode;
}

/// List of all countries with their codes and phone numbers
const List<Country> countries = [
  Country(code: 'AD', label: 'Andorra', phone: '376'),
  Country(code: 'AE', label: 'United Arab Emirates', phone: '971'),
  Country(code: 'AF', label: 'Afghanistan', phone: '93'),
  Country(code: 'AG', label: 'Antigua and Barbuda', phone: '1-268'),
  Country(code: 'AI', label: 'Anguilla', phone: '1-264'),
  Country(code: 'AL', label: 'Albania', phone: '355'),
  Country(code: 'AM', label: 'Armenia', phone: '374'),
  Country(code: 'AO', label: 'Angola', phone: '244'),
  Country(code: 'AQ', label: 'Antarctica', phone: '672'),
  Country(code: 'AR', label: 'Argentina', phone: '54'),
  Country(code: 'AS', label: 'American Samoa', phone: '1-684'),
  Country(code: 'AT', label: 'Austria', phone: '43'),
  Country(code: 'AU', label: 'Australia', phone: '61', suggested: true),
  Country(code: 'AW', label: 'Aruba', phone: '297'),
  Country(code: 'AX', label: 'Alland Islands', phone: '358'),
  Country(code: 'AZ', label: 'Azerbaijan', phone: '994'),
  Country(code: 'BA', label: 'Bosnia and Herzegovina', phone: '387'),
  Country(code: 'BB', label: 'Barbados', phone: '1-246'),
  Country(code: 'BD', label: 'Bangladesh', phone: '880'),
  Country(code: 'BE', label: 'Belgium', phone: '32'),
  Country(code: 'BF', label: 'Burkina Faso', phone: '226'),
  Country(code: 'BG', label: 'Bulgaria', phone: '359'),
  Country(code: 'BH', label: 'Bahrain', phone: '973'),
  Country(code: 'BI', label: 'Burundi', phone: '257'),
  Country(code: 'BJ', label: 'Benin', phone: '229'),
  Country(code: 'BL', label: 'Saint Barthelemy', phone: '590'),
  Country(code: 'BM', label: 'Bermuda', phone: '1-441'),
  Country(code: 'BN', label: 'Brunei Darussalam', phone: '673'),
  Country(code: 'BO', label: 'Bolivia', phone: '591'),
  Country(code: 'BR', label: 'Brazil', phone: '55'),
  Country(code: 'BS', label: 'Bahamas', phone: '1-242'),
  Country(code: 'BT', label: 'Bhutan', phone: '975'),
  Country(code: 'BV', label: 'Bouvet Island', phone: '47'),
  Country(code: 'BW', label: 'Botswana', phone: '267'),
  Country(code: 'BY', label: 'Belarus', phone: '375'),
  Country(code: 'BZ', label: 'Belize', phone: '501'),
  Country(code: 'CA', label: 'Canada', phone: '1', suggested: true),
  Country(code: 'CC', label: 'Cocos (Keeling) Islands', phone: '61'),
  Country(code: 'CD', label: 'Congo, Democratic Republic of the', phone: '243'),
  Country(code: 'CF', label: 'Central African Republic', phone: '236'),
  Country(code: 'CG', label: 'Congo, Republic of the', phone: '242'),
  Country(code: 'CH', label: 'Switzerland', phone: '41'),
  Country(code: 'CI', label: 'Cote d\'Ivoire', phone: '225'),
  Country(code: 'CK', label: 'Cook Islands', phone: '682'),
  Country(code: 'CL', label: 'Chile', phone: '56'),
  Country(code: 'CM', label: 'Cameroon', phone: '237'),
  Country(code: 'CN', label: 'China', phone: '86'),
  Country(code: 'CO', label: 'Colombia', phone: '57'),
  Country(code: 'CR', label: 'Costa Rica', phone: '506'),
  Country(code: 'CU', label: 'Cuba', phone: '53'),
  Country(code: 'CV', label: 'Cape Verde', phone: '238'),
  Country(code: 'CW', label: 'Curaçao', phone: '599'),
  Country(code: 'CX', label: 'Christmas Island', phone: '61'),
  Country(code: 'CY', label: 'Cyprus', phone: '357'),
  Country(code: 'CZ', label: 'Czech Republic', phone: '420'),
  Country(code: 'DE', label: 'Germany', phone: '49', suggested: true),
  Country(code: 'DJ', label: 'Djibouti', phone: '253'),
  Country(code: 'DK', label: 'Denmark', phone: '45'),
  Country(code: 'DM', label: 'Dominica', phone: '1-767'),
  Country(code: 'DO', label: 'Dominican Republic', phone: '1-849'),
  Country(code: 'DZ', label: 'Algeria', phone: '213'),
  Country(code: 'EC', label: 'Ecuador', phone: '593'),
  Country(code: 'EE', label: 'Estonia', phone: '372'),
  Country(code: 'EG', label: 'Egypt', phone: '20'),
  Country(code: 'EH', label: 'Western Sahara', phone: '212'),
  Country(code: 'ER', label: 'Eritrea', phone: '291'),
  Country(code: 'ES', label: 'Spain', phone: '34'),
  Country(code: 'ET', label: 'Ethiopia', phone: '251'),
  Country(code: 'FI', label: 'Finland', phone: '358'),
  Country(code: 'FJ', label: 'Fiji', phone: '679'),
  Country(code: 'FK', label: 'Falkland Islands (Malvinas)', phone: '500'),
  Country(code: 'FM', label: 'Micronesia, Federated States of', phone: '691'),
  Country(code: 'FO', label: 'Faroe Islands', phone: '298'),
  Country(code: 'FR', label: 'France', phone: '33', suggested: true),
  Country(code: 'GA', label: 'Gabon', phone: '241'),
  Country(code: 'GB', label: 'United Kingdom', phone: '44'),
  Country(code: 'GD', label: 'Grenada', phone: '1-473'),
  Country(code: 'GE', label: 'Georgia', phone: '995'),
  Country(code: 'GF', label: 'French Guiana', phone: '594'),
  Country(code: 'GG', label: 'Guernsey', phone: '44'),
  Country(code: 'GH', label: 'Ghana', phone: '233'),
  Country(code: 'GI', label: 'Gibraltar', phone: '350'),
  Country(code: 'GL', label: 'Greenland', phone: '299'),
  Country(code: 'GM', label: 'Gambia', phone: '220'),
  Country(code: 'GN', label: 'Guinea', phone: '224'),
  Country(code: 'GP', label: 'Guadeloupe', phone: '590'),
  Country(code: 'GQ', label: 'Equatorial Guinea', phone: '240'),
  Country(code: 'GR', label: 'Greece', phone: '30'),
  Country(code: 'GS', label: 'South Georgia and the South Sandwich Islands', phone: '500'),
  Country(code: 'GT', label: 'Guatemala', phone: '502'),
  Country(code: 'GU', label: 'Guam', phone: '1-671'),
  Country(code: 'GW', label: 'Guinea-Bissau', phone: '245'),
  Country(code: 'GY', label: 'Guyana', phone: '592'),
  Country(code: 'HK', label: 'Hong Kong', phone: '852'),
  Country(code: 'HM', label: 'Heard Island and McDonald Islands', phone: '672'),
  Country(code: 'HN', label: 'Honduras', phone: '504'),
  Country(code: 'HR', label: 'Croatia', phone: '385'),
  Country(code: 'HT', label: 'Haiti', phone: '509'),
  Country(code: 'HU', label: 'Hungary', phone: '36'),
  Country(code: 'ID', label: 'Indonesia', phone: '62'),
  Country(code: 'IE', label: 'Ireland', phone: '353'),
  Country(code: 'IL', label: 'Israel', phone: '972'),
  Country(code: 'IM', label: 'Isle of Man', phone: '44'),
  Country(code: 'IN', label: 'India', phone: '91'),
  Country(code: 'IO', label: 'British Indian Ocean Territory', phone: '246'),
  Country(code: 'IQ', label: 'Iraq', phone: '964'),
  Country(code: 'IR', label: 'Iran, Islamic Republic of', phone: '98'),
  Country(code: 'IS', label: 'Iceland', phone: '354'),
  Country(code: 'IT', label: 'Italy', phone: '39'),
  Country(code: 'JE', label: 'Jersey', phone: '44'),
  Country(code: 'JM', label: 'Jamaica', phone: '1-876'),
  Country(code: 'JO', label: 'Jordan', phone: '962'),
  Country(code: 'JP', label: 'Japan', phone: '81', suggested: true),
  Country(code: 'KE', label: 'Kenya', phone: '254'),
  Country(code: 'KG', label: 'Kyrgyzstan', phone: '996'),
  Country(code: 'KH', label: 'Cambodia', phone: '855'),
  Country(code: 'KI', label: 'Kiribati', phone: '686'),
  Country(code: 'KM', label: 'Comoros', phone: '269'),
  Country(code: 'KN', label: 'Saint Kitts and Nevis', phone: '1-869'),
  Country(code: 'KP', label: 'Korea, Democratic People\'s Republic of', phone: '850'),
  Country(code: 'KR', label: 'Korea, Republic of', phone: '82'),
  Country(code: 'KW', label: 'Kuwait', phone: '965'),
  Country(code: 'KY', label: 'Cayman Islands', phone: '1-345'),
  Country(code: 'KZ', label: 'Kazakhstan', phone: '7'),
  Country(code: 'LA', label: 'Lao People\'s Democratic Republic', phone: '856'),
  Country(code: 'LB', label: 'Lebanon', phone: '961'),
  Country(code: 'LC', label: 'Saint Lucia', phone: '1-758'),
  Country(code: 'LI', label: 'Liechtenstein', phone: '423'),
  Country(code: 'LK', label: 'Sri Lanka', phone: '94'),
  Country(code: 'LR', label: 'Liberia', phone: '231'),
  Country(code: 'LS', label: 'Lesotho', phone: '266'),
  Country(code: 'LT', label: 'Lithuania', phone: '370'),
  Country(code: 'LU', label: 'Luxembourg', phone: '352'),
  Country(code: 'LV', label: 'Latvia', phone: '371'),
  Country(code: 'LY', label: 'Libya', phone: '218'),
  Country(code: 'MA', label: 'Morocco', phone: '212'),
  Country(code: 'MC', label: 'Monaco', phone: '377'),
  Country(code: 'MD', label: 'Moldova, Republic of', phone: '373'),
  Country(code: 'ME', label: 'Montenegro', phone: '382'),
  Country(code: 'MF', label: 'Saint Martin (French part)', phone: '590'),
  Country(code: 'MG', label: 'Madagascar', phone: '261'),
  Country(code: 'MH', label: 'Marshall Islands', phone: '692'),
  Country(code: 'MK', label: 'Macedonia, the Former Yugoslav Republic of', phone: '389'),
  Country(code: 'ML', label: 'Mali', phone: '223'),
  Country(code: 'MM', label: 'Myanmar', phone: '95'),
  Country(code: 'MN', label: 'Mongolia', phone: '976'),
  Country(code: 'MO', label: 'Macao', phone: '853'),
  Country(code: 'MP', label: 'Northern Mariana Islands', phone: '1-670'),
  Country(code: 'MQ', label: 'Martinique', phone: '596'),
  Country(code: 'MR', label: 'Mauritania', phone: '222'),
  Country(code: 'MS', label: 'Montserrat', phone: '1-664'),
  Country(code: 'MT', label: 'Malta', phone: '356'),
  Country(code: 'MU', label: 'Mauritius', phone: '230'),
  Country(code: 'MV', label: 'Maldives', phone: '960'),
  Country(code: 'MW', label: 'Malawi', phone: '265'),
  Country(code: 'MX', label: 'Mexico', phone: '52'),
  Country(code: 'MY', label: 'Malaysia', phone: '60'),
  Country(code: 'MZ', label: 'Mozambique', phone: '258'),
  Country(code: 'NA', label: 'Namibia', phone: '264'),
  Country(code: 'NC', label: 'New Caledonia', phone: '687'),
  Country(code: 'NE', label: 'Niger', phone: '227'),
  Country(code: 'NF', label: 'Norfolk Island', phone: '672'),
  Country(code: 'NG', label: 'Nigeria', phone: '234'),
  Country(code: 'NI', label: 'Nicaragua', phone: '505'),
  Country(code: 'NL', label: 'Netherlands', phone: '31'),
  Country(code: 'NO', label: 'Norway', phone: '47'),
  Country(code: 'NP', label: 'Nepal', phone: '977'),
  Country(code: 'NR', label: 'Nauru', phone: '674'),
  Country(code: 'NU', label: 'Niue', phone: '683'),
  Country(code: 'NZ', label: 'New Zealand', phone: '64'),
  Country(code: 'OM', label: 'Oman', phone: '968'),
  Country(code: 'PA', label: 'Panama', phone: '507'),
  Country(code: 'PE', label: 'Peru', phone: '51'),
  Country(code: 'PF', label: 'French Polynesia', phone: '689'),
  Country(code: 'PG', label: 'Papua New Guinea', phone: '675'),
  Country(code: 'PH', label: 'Philippines', phone: '63'),
  Country(code: 'PK', label: 'Pakistan', phone: '92'),
  Country(code: 'PL', label: 'Poland', phone: '48'),
  Country(code: 'PM', label: 'Saint Pierre and Miquelon', phone: '508'),
  Country(code: 'PN', label: 'Pitcairn', phone: '870'),
  Country(code: 'PR', label: 'Puerto Rico', phone: '1'),
  Country(code: 'PS', label: 'Palestine, State of', phone: '970'),
  Country(code: 'PT', label: 'Portugal', phone: '351'),
  Country(code: 'PW', label: 'Palau', phone: '680'),
  Country(code: 'PY', label: 'Paraguay', phone: '595'),
  Country(code: 'QA', label: 'Qatar', phone: '974'),
  Country(code: 'RE', label: 'Réunion', phone: '262'),
  Country(code: 'RO', label: 'Romania', phone: '40'),
  Country(code: 'RS', label: 'Serbia', phone: '381'),
  Country(code: 'RU', label: 'Russian Federation', phone: '7'),
  Country(code: 'RW', label: 'Rwanda', phone: '250'),
  Country(code: 'SA', label: 'Saudi Arabia', phone: '966'),
  Country(code: 'SB', label: 'Solomon Islands', phone: '677'),
  Country(code: 'SC', label: 'Seychelles', phone: '248'),
  Country(code: 'SD', label: 'Sudan', phone: '249'),
  Country(code: 'SE', label: 'Sweden', phone: '46'),
  Country(code: 'SG', label: 'Singapore', phone: '65'),
  Country(code: 'SH', label: 'Saint Helena', phone: '290'),
  Country(code: 'SI', label: 'Slovenia', phone: '386'),
  Country(code: 'SJ', label: 'Svalbard and Jan Mayen', phone: '47'),
  Country(code: 'SK', label: 'Slovakia', phone: '421'),
  Country(code: 'SL', label: 'Sierra Leone', phone: '232'),
  Country(code: 'SM', label: 'San Marino', phone: '378'),
  Country(code: 'SN', label: 'Senegal', phone: '221'),
  Country(code: 'SO', label: 'Somalia', phone: '252'),
  Country(code: 'SR', label: 'Suriname', phone: '597'),
  Country(code: 'SS', label: 'South Sudan', phone: '211'),
  Country(code: 'ST', label: 'Sao Tome and Principe', phone: '239'),
  Country(code: 'SV', label: 'El Salvador', phone: '503'),
  Country(code: 'SX', label: 'Sint Maarten (Dutch part)', phone: '1-721'),
  Country(code: 'SY', label: 'Syrian Arab Republic', phone: '963'),
  Country(code: 'SZ', label: 'Swaziland', phone: '268'),
  Country(code: 'TC', label: 'Turks and Caicos Islands', phone: '1-649'),
  Country(code: 'TD', label: 'Chad', phone: '235'),
  Country(code: 'TF', label: 'French Southern Territories', phone: '262'),
  Country(code: 'TG', label: 'Togo', phone: '228'),
  Country(code: 'TH', label: 'Thailand', phone: '66'),
  Country(code: 'TJ', label: 'Tajikistan', phone: '992'),
  Country(code: 'TK', label: 'Tokelau', phone: '690'),
  Country(code: 'TL', label: 'Timor-Leste', phone: '670'),
  Country(code: 'TM', label: 'Turkmenistan', phone: '993'),
  Country(code: 'TN', label: 'Tunisia', phone: '216'),
  Country(code: 'TO', label: 'Tonga', phone: '676'),
  Country(code: 'TR', label: 'Turkey', phone: '90'),
  Country(code: 'TT', label: 'Trinidad and Tobago', phone: '1-868'),
  Country(code: 'TV', label: 'Tuvalu', phone: '688'),
  Country(code: 'TW', label: 'Taiwan, Province of China', phone: '886'),
  Country(code: 'TZ', label: 'United Republic of Tanzania', phone: '255'),
  Country(code: 'UA', label: 'Ukraine', phone: '380'),
  Country(code: 'UG', label: 'Uganda', phone: '256'),
  Country(code: 'US', label: 'United States', phone: '1', suggested: true),
  Country(code: 'UY', label: 'Uruguay', phone: '598'),
  Country(code: 'UZ', label: 'Uzbekistan', phone: '998'),
  Country(code: 'VA', label: 'Holy See (Vatican City State)', phone: '379'),
  Country(code: 'VC', label: 'Saint Vincent and the Grenadines', phone: '1-784'),
  Country(code: 'VE', label: 'Venezuela', phone: '58'),
  Country(code: 'VG', label: 'British Virgin Islands', phone: '1-284'),
  Country(code: 'VI', label: 'US Virgin Islands', phone: '1-340'),
  Country(code: 'VN', label: 'Vietnam', phone: '84'),
  Country(code: 'VU', label: 'Vanuatu', phone: '678'),
  Country(code: 'WF', label: 'Wallis and Futuna', phone: '681'),
  Country(code: 'WS', label: 'Samoa', phone: '685'),
  Country(code: 'XK', label: 'Kosovo', phone: '383'),
  Country(code: 'YE', label: 'Yemen', phone: '967'),
  Country(code: 'YT', label: 'Mayotte', phone: '262'),
  Country(code: 'ZA', label: 'South Africa', phone: '27'),
  Country(code: 'ZM', label: 'Zambia', phone: '260'),
  Country(code: 'ZW', label: 'Zimbabwe', phone: '263'),
];

/// Utility functions for working with countries
class CountryUtils {
  /// Get country by code
  static Country? getCountryByCode(String code) {
    try {
      return countries.firstWhere((country) => country.code == code);
    } catch (e) {
      return null;
    }
  }

  /// Get suggested countries
  static List<Country> get suggestedCountries {
    return countries.where((country) => country.suggested).toList();
  }

  /// Search countries by name or code
  static List<Country> searchCountries(String query) {
    if (query.isEmpty) return countries;

    final lowercaseQuery = query.toLowerCase();
    return countries.where((country) => country.label.toLowerCase().contains(lowercaseQuery) || country.code.toLowerCase().contains(lowercaseQuery)).toList();
  }

  /// Get countries sorted by name
  static List<Country> get sortedCountries {
    final sorted = List<Country>.from(countries);
    sorted.sort((a, b) => a.label.compareTo(b.label));
    return sorted;
  }
}
