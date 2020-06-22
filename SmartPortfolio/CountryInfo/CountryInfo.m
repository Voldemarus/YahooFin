//
//  CountryInfo.m
//  Weather
//
//  Created by Водолазкий В.В. on 10.02.16.
//  Copyright © 2016 Geomatix Laboratoriess S.R.O. All rights reserved.
//

#import "CountryInfo.h"

@interface CountryInfo ()
{
	NSArray *countries;
}

@end

@implementation CountryInfo


+ (CountryInfo *) sharedInstance
{
	static CountryInfo *singleton = nil;
	if (!singleton) {
		singleton = [[CountryInfo alloc] init];
	}
	return singleton;
}

- (id) init
{
	if (self = [super init]) {
		// Create ordered array
		NSMutableArray *tmp = [[NSMutableArray alloc] initWithCapacity:300];
		for (NSString *key in [self countryData]) {
			NSString *cName = [self countryNameForCode:key];
			UIImage *cImage = [self countryFlagForCode:key];
			NSArray *cData = @[
									key,
									cName,
									cImage,
									];
			[tmp addObject:cData];
		}
		// sort array to get proper order
		countries = [[NSArray alloc] initWithArray:[tmp sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
			NSString *a = [(NSArray *)obj1 objectAtIndex:1];
			NSString *b = [(NSArray *)obj2 objectAtIndex:1];
			return [a compare:b];
		}]];
	}
	return self;
}

- (NSArray *) countries
{
	return countries;
}

- (NSInteger) defaultIndex
{
	for (NSInteger i = 0; i < countries.count; i++) {
		NSArray *cData = countries[i];
		if ([cData[0] isEqualToString:@"US"]) {
			return i;
		}
	}
	return 0;
}

- (NSArray *) countryCodes
{
	NSArray *allCodes = [[self countryData] allKeys];
	return [allCodes sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
}


- (UIImage *) countryFlagForCode:(NSString *)countryCode
{
	if (!countryCode) return nil;
	NSArray *cData = [[self countryData] objectForKey:countryCode];
	if (cData) {
		NSBundle *mb = [NSBundle mainBundle];
		NSString *pth = [mb pathForResource:cData[0] ofType:@"png"];
		if (!pth) {
#warning FIX ME ! filler for flag is used
			pth = [mb pathForResource:@"tibet" ofType:@"png"];
		}
		if (pth) {
			UIImage *img = [UIImage imageNamed:pth];
			return img;
		}
	}
	return nil;
}

- (NSString *) countryNameForCode:(NSString *)countryCode
{
	if (!countryCode) return nil;
	NSArray *cData = [[self countryData] objectForKey:countryCode];
	if (cData) {
		return cData[1];
	}
	return nil;

}

// https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2#ES

- (NSDictionary *) countryData
{
	return @{
			 @"AD" :	@[@"andorra", @"Andorra"],
			 @"AE" :	@[@"united_arab_emirates", @"United Arab Emirates"],
			 @"AF" :	@[@"afghanistan", @"Afghanistan"],
			 @"AG" :	@[@"antigua_barbuda", @"Antigua and Barbuda"],
			 @"AI" :	@[@"anguilla", @"Anguilla"],
			 @"AL" :	@[@"albania", @"Albania"],
			 @"AM" :	@[@"armenia",@"Armenia"],
			 @"AO" :	@[@"angola", @"Angola"],
			 @"AQ" :	@[@"antarctica", @"Antarctica"],
			 @"AR" :	@[@"argentina",@"Argentina"],
			 @"AS" :	@[@"american_samoa", @"American Samoa"],
			 @"AT" :	@[@"austria", @"Austria"],
			 @"AU" :	@[@"australia", @"Australia"],
			 @"AW" :	@[@"aruba", @"Aruba"],
			 @"AX" :	@[@"finland", @"Åland Islands"],			// no flag data :-(
			 @"AZ" :	@[@"azerbaijan", @"Azerbaijan"],
			 @"BA" :	@[@"bosnia_herzegovina", @"Bosnia and Herzegovina"],
			 @"BB" :	@[@"barbados", @"Barbados"],
			 @"BD" :	@[@"bangladesh", @"Bangladesh"],
			 @"BE" :	@[@"belgium", @"Belgium"],
			 @"BF" :	@[@"burkina_faso", @"Burkina Faso"],
			 @"BG" :	@[@"bulgaria", @"Bulgaria"],
			 @"BH" :	@[@"bahrain", @"Bahrain"],
			 @"BI" :	@[@"burundi", @"Burundi"],
			 @"BJ" :	@[@"benin", @"Benin"],
			 @"BL" :	@[@"", @"Saint Barthélemy"],// 	2007 No Flag !!!
			 @"BM" :	@[@"bermuda", @"Bermuda"],
			 @"BN" :	@[@"brunei", @"Brunei Darussalam"],
			 @"BO" :    @[@"bolivia",@"Bolivia"], 
			 @"BQ" :	@[@"netherlands_antilles", @"Bonaire, Sint Eustatius and Saba"],
			 @"BQ" :	@[@"british_antarctic_territory", @"British Antarctic Territory"],
			 @"BR":		@[@"brazil",@"Brazil"],
			 @"BS" :	@[@"bahamas", @"Bahamas"],
			 @"BT" :	@[@"bhutan", @"Bhutan"],
			 @"BV" :	@[@"norway", @"Bouvet Island"],//	Belongs to Norway
			 @"BW" :	@[@"botswana", @"Botswana"],
			 @"BY" :	@[@"belarus", @"Belarus"],
			 @"BZ" :	@[@"belize", @"Belize"],
			 @"CA" :	@[@"canada", @"Canada"],
			 @"CC" :	@[@"", @"Cocos (Keeling) Islands"],	 // No flag!
			 @"CD" :	@[@"zaire", @"Congo"],
			 @"CF" :	@[@"central_african_republic", @"Central African Republic"],
			 @"CG" :	@[@"congo_brazzaville", @"Congo"],
			 @"CH" :	@[@"switzerland", @"Switzerland"],
			 @"CI" :	@[@"cote_d_ivoire", @"Côte d'Ivoire"],
			 @"CK" :	@[@"cook_islands", @"Cook Islands"],
			 @"CL" :	@[@"chile", @"Chile"],
			 @"CM" :	@[@"cameroon", @"Cameroon"],
			 @"CN" :	@[@"china", @"China"],
			 @"CO" :	@[@"colombia", @"Colombia"],
			 @"CR" :	@[@"costa_rica", @"Costa Rica"],
			 @"CU" :	@[@"cuba", @"Cuba"],
			 @"CV" :	@[@"cape_verde", @"Cabo Verde"],
			 @"CW" :	@[@"", @"Curaçao"],					// No flag ???
			 @"CX" :	@[@"christmas_island", @"Christmas Island"],
			 @"CY" :    @[@"cyprus",@"Cyprus"],
			 @"CZ" :	@[@"czec_republic", @"Czech Republic"],
			 @"DE" :	@[@"germany", @"Germany"],
			 @"DJ" :	@[@"dijibouti", @"Djibouti"],
			 @"DK" :	@[@"denmark", @"Denmark"],
			 @"DM" :	@[@"dominica", @"Dominica"],
			 @"DO" :	@[@"dominican_republic", @"Dominican Republic"],
			 @"DZ" :	@[@"algeria", @"Algeria"],
			 @"EC" :	@[@"ecuador", @"Ecuador"],
			 @"EE" :	@[@"estonia", @"Estonia"],
			 @"EG" :	@[@"egypt", @"Egypt"],
			 @"EH" :	@[@"western_sahara", @"Western Sahara"],
			 @"ER" :	@[@"eritrea", @"Eritrea"],
			 @"ES" :	@[@"spain", @"Spain"],
			 @"ET" :	@[@"ethiopia", @"Ethiopia"],
			 @"FI" :	@[@"finland",@"Finland"],
			 @"FJ" :	@[@"fiji", @"Fiji"],
			 @"FK" :	@[@"falkland_islands",@"Falkland Islands"],
			 @"FM" :	@[@"micronesia", @"Micronesia"],
			 @"FO" :	@[@"faroes", @"Faroe Islands"],
			 @"FR" :	@[@"france", @"France"],
			 @"GA" :	@[@"gabon", @"Gabon"],
			 @"GB" :	@[@"britain",@"Great Britain"],
			 @"UK" :	@[@"britain",@"Great Britain"],
			 @"GD" :	@[@"grenada", @"Grenada"],
			 @"GE" :	@[@"georgia", @"Georgia"],
			 @"GF" :	@[@"guyana", @"French Guiana"],
			 @"GG" :	@[@"guernsey", @"Guernsey"],
			 @"GH" :	@[@"ghana", @"Ghana"],
			 @"GI" :	@[@"gibraltar", @"Gibraltar"],
			 @"GL" :	@[@"greenland", @"Greenland"],
			 @"GM" :	@[@"gambia", @"Gambia"],
			 @"GN" :	@[@"guinea", @"Guinea"],
			 @"GP" :	@[@"", @"Guadeloupe"],				// No Fla g ???
			 @"GQ" :	@[@"equatorial_guinea", @"Equatorial Guinea"],	
			 @"GR" :	@[@"greece", @"Greece"],
			 @"GS" :	@[@"south_georgia_south_sandwich_islands", @"Sandwich Islands"],
			 @"GT" :	@[@"guatemala", @"Guatemala"],
			 @"GU" :	@[@"guam", @"Guam"],
			 @"GW" :	@[@"guinea_bissau", @"Guinea-Bissau"],
			 @"GY" :	@[@"guyana", @"Guyana"],
			 @"HK" :	@[@"hong_kong", @"Hong Kong"],
			 @"HM" :	@[@"", @"Heard Island and McDonald Islands"],	// No Flag ???
			 @"HN" :	@[@"honduras", @"Honduras"],
			 @"HR" :	@[@"croatia", @"Croatia"],
			 @"HT" :	@[@"haiti", @"Haiti"],
			 @"HU" :	@[@"hungary", @"Hungary"],
			 @"ID" :	@[@"indonesia", @"Indonesia"],
			 @"IE" :	@[@"ireland", @"Ireland"],
			 @"IL" :	@[@"", @"Israel"],					// No flag ???
			 @"IM" :	@[@"isle_of_man", @"Isle of Man"],
			 @"IN" :	@[@"india", @"India"],
			 @"IO" :	@[@"british_indian_ocean_territory",
						  @"British Indian Ocean Territory"],
			 @"IQ" :	@[@"iraq", @"Iraq"],
			 @"IR" :	@[@"iran", @"Iran"],
			 @"IS" :	@[@"iceland", @"Iceland"],
			 @"IT" :	@[@"italy", @"Italy"],
			 @"JE" :	@[@"jersey", @"Jersey"],
			 @"JM" :	@[@"jamaica", @"Jamaica"],
			 @"JO" :	@[@"jordan", @"Jordan"],	
			 @"JP" :	@[@"japan", @"Japan"],
			 @"KE" :	@[@"kenya", @"Kenya"],
			 @"KG" :	@[@"kyrgyzstan", @"Kyrgyzstan"],
			 @"KH" :	@[@"cambodia", @"Cambodia"],
			 @"KI" :	@[@"kiribati", @"Kiribati"],
			 @"KM" :	@[@"comoros", @"Comoros"],	
			 @"KN" :	@[@"", @"Saint Kitts and Nevis"],		// No flag ???
			 @"KP" :	@[@"north_korea", @"Noth Korea"],
			 @"KR" :	@[@"south_korea", @"South Korea"],
			 @"KW" :	@[@"kuwait", @"Kuwait"],
			 @"KY" :	@[@"cayman_islands", @"Cayman Islands"],
			 @"KZ" :	@[@"kazakhstan", @"Kazakhstan"],
			 @"LA" :	@[@"laos", @"Laos"],
			 @"LB" :	@[@"lebanon", @"Lebanon"],
			 @"LC" :	@[@"st_lucia", @"Saint Lucia"],
			 @"LI" :	@[@"liechtenstein", @"Liechtenstein"],
			 @"LK" :	@[@"sri_lanka", @"Sri Lanka"],
			 @"LR" :	@[@"liberia", @"Liberia"],
			 @"LS" :	@[@"lesotho", @"Lesotho"],
			 @"LT" :	@[@"lithuania", @"Lithuania"],
			 @"LU" :	@[@"luxembourg", @"Luxembourg"],
			 @"LV" :	@[@"latvia", @"Latvia"],
			 @"LY" :	@[@"", @"Libya"],					// No flag ???
			 @"MA" :	@[@"morocco", @"Morocco"],
			 @"MC" :	@[@"monaco", @"Monaco"],
			 @"MD" :	@[@"moldova", @"Moldova"],
			 @"ME" :	@[@"montenegro", @"Montenegro"],
			 @"MF" :	@[@"france", @"Saint Martin (French)"], //  (French part)
			 @"SX" :	@[@"netherlands", @"Saint Martin (Dutch) "], //  (Dutch part)
			 @"MG" :	@[@"madagascar", @"Madagascar"],
			 @"MH" :	@[@"marshall_islands", @"Marshall Islands"],
			 @"MK" :	@[@"macedonia", @"Macedonia"],
			 @"ML" :	@[@"mali", @"Mali"],
			 @"MM" :	@[@"myanmar", @"Myanmar"],
			 @"MN" :	@[@"mongolia", @"Mongolia"],
			 @"MO" :	@[@"macao", @"Macao"],
			 @"MP" :	@[@"northern_marianas", @"Northern Mariana Islands"],
			 @"MQ" :	@[@"", @"Martinique"],					// No flag ???
			 @"MR" :	@[@"mauritania", @"Mauritania"],
			 @"MS" :	@[@"montserrat", @"Montserrat"],
			 @"MT" :	@[@"malta", @"Malta"],
			 @"MU" :	@[@"mauritius", @"Mauritius"],
			 @"MV" :	@[@"maldives", @"Maldives"],
			 @"MW" :	@[@"malawi", @"Malawi"],
			 @"MX" :	@[@"mexico", @"Mexico"],
			 @"MY" :	@[@"malaysia", @"Malaysia"],
			 @"MZ" :	@[@"mozambique", @"Mozambique"],
			 @"NA" :	@[@"namibia", @"Namibia"],
			 @"NC" :	@[@"new_caledonia", @"New Caledonia"],
			 @"NE" :	@[@"niger", @"Niger"],
			 @"NF" :	@[@"norfolk_island", @"Norfolk Island"],
			 @"NG" :	@[@"nigeria", @"Nigeria"],
			 @"NI" :	@[@"nicaragua", @"Nicaragua"],
			 @"NL" :	@[@"netherlands", @"Netherlands"],
			 @"NO" :	@[@"norway",@"Norway"],
			 @"NP" :	@[@"nepal", @"Nepal"],
			 @"NR" :	@[@"nauru", @"Nauru"],
			 @"NU" :	@[@"niue", @"Niue"],
			 @"NZ" :	@[@"new_zealand",@"New Zealand"],
			 @"OM" :	@[@"oman", @"Oman"],
			 @"PA" :	@[@"panama", @"Panama"],
			 @"PE" :	@[@"peru", @"Peru"],
			 @"PF" :	@[@"french_polynesia", @"French Polynesia"],
			 @"PG" :	@[@"papua_new_guinea", @"Papua New Guinea"],
			 @"PH" :	@[@"phillipines", @"Philippines"],
			 @"PK" : 	@[@"pakistan", @"Pakistan"],
			 @"PL" :	@[@"poland", @"Poland"],
			 @"PM" :	@[@"", @"Saint Pierre and Miquelon"],		// No Flag ???
			 @"PN" :	@[@"pitcairn_islands", @"Pitcairn"],
			 @"PR" :	@[@"puerto_rico", @"Puerto Rico"],
			 @"PS" :	@[@"palestine", @"Palestine"],
			 @"PT" :	@[@"portugal", @"Portugal"],
			 @"PW" :	@[@"palau", @"Palau"],
			 @"PY" :	@[@"paraguay", @"Paraguay"],
			 @"QA" :	@[@"qatar", @"Qatar"],
			 @"RE" :	@[@"reunion", @"Réunion"],
			 @"RO" :	@[@"romania", @"Romania"],
			 @"RS" :	@[@"serbia", @"Serbia"],
			 @"RU" :	@[@"russian_federation", @"Russian Federation"],
			 @"RW" :	@[@"rwanda", @"Rwanda"],
			 @"SA" :	@[@"saudi_arabia", @"Saudi Arabia"],
			 @"SB" :	@[@"solomon_islands", @"Solomon Islands"],	
			 @"SC" :	@[@"seychelles", @"Seychelles"],
			 @"SD" :	@[@"sudan", @"Sudan"],
			 @"SE" :	@[@"sweden", @"Sweden"],
			 @"SG" :	@[@"singapore", @"Singapore"],
			 @"SH" :	@[@"st_helena", @"Saint Helena"],
			 @"SI" :	@[@"slovenia", @"Slovenia"],
			 @"SJ" :	@[@"norway", @"Svalbard and Jan Mayen"],
			 @"SK" :	@[@"slovakia", @"Slovakia"],
			 @"SL" :	@[@"sierra_leone", @"Sierra Leone"],
			 @"SM" :	@[@"san_marino", @"San Marino"],
			 @"SN" :	@[@"senegal", @"Senegal"],
			 @"SO" :	@[@"somalia", @"Somalia"],
			 @"SR" :	@[@"suriname", @"Suriname"],
			 @"SS" :	@[@"", @"South Sudan"],						// No flag ???
			 @"ST" :	@[@"sao_tome_principe", @"Sao Tome and Principe"],
			 @"SV" :	@[@"el_salvador", @"El Salvador"],
			 @"SY" :	@[@"syria", @"Syria"],
			 @"SZ" :	@[@"swaziland", @"Swaziland"],
			 @"TC" :	@[@"turks_caicos_islands",@"Turks and Caicos Islands"],
			 @"TD" :	@[@"chad", @"Chad"],
			 @"TF" :	@[@"french_southern_antarctic_lands",
						  @"French Southern Territories"],
			 @"TG" :	@[@"togo", @"Togo"],
			 @"TH" :	@[@"thailand", @"Thailand"],
			 @"TJ" :	@[@"tajikstan", @"Tajikistan"],
			 @"TK" :	@[@"tokelau", @"Tokelau"],
			 @"TL" :	@[@"timor_leste", @"Timor-Leste"],
			 @"TM" :	@[@"turkmenistan", @"Turkmenistan"],
			 @"TN" :	@[@"tunisia", @"Tunisia"],
			 @"TO" :	@[@"tonga", @"Tonga"],
			 @"TR" :	@[@"turkey", @"Turkey"],
			 @"TT" :	@[@"trinidad_tobago", @"Trinidad and Tobago"],
			 @"TV" :	@[@"", @"Tuvalu"],					// No flags ???
			 @"TW" :	@[@"taiwan", @"Taiwan"],
			 @"TZ" :	@[@"tanzania", @"Tanzania"],
			 @"UA" :	@[@"ukraine", @"Ukraine"],
			 @"UG" :	@[@"uganda", @"Uganda"],
			 @"UM" :	@[@"united_states", @"United States Minor Outlying Islands"],
			 @"US" :	@[@"united_states", @"United States of America"],
			 @"UY" :	@[@"uruguay", @"Uruguay"],
			 @"UZ" :	@[@"uzbekistan", @"Uzbekistan"],
			 @"VA" :	@[@"holy_see", @"Holy See"],
			 @"VC" :	@[@"st_vincent_grenadines", @"Saint Vincent and the Grenadines"],
			 @"VE" :	@[@"venezuela", @"Venezuela"],
			 @"VG" :	@[@"britain", @"Virgin Islands, British"],
			 @"VI" :	@[@"virgin_islands", @"Virgin Islands, U.S."],	
			 @"VN" :	@[@"vietnam", @"Vietnam"],
			 @"VU" :	@[@"vanuatu",@"Vanuatu"],
			 @"WF" :	@[@"wales", @"Wallis and Futuna"],
			 @"WS" :	@[@"samoa", @"Samoa"],
			 @"YE" :	@[@"yemen", @"Yemen"],
			 @"YT" : 	@[@"", @"Mayotte"],				// No flag ???
			 @"ZA" :	@[@"south_africa", @"South Africa"],
			 @"ZM" :	@[@"zambia", @"Zambia"],
			 @"ZW" :	@[@"zimbabwe", @"Zimbabwe"],
			 };
}

@end
