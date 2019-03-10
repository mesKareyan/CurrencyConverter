//
//  ImageManager.swift
//  Revolut iOS Test Application
//
//  Created by Mesrop Kareyan on 10/03/2019.
//  Copyright © 2019 Mesrop Kareyan. All rights reserved.
//

import Foundation

class Currency {
	
	enum Item: String {
		
		case EUR
		case AUD
		case BGN
		case BRL
		case CAD
		case CHF
		case CNY
		case CZK
		case DKK
		case GBP
		case HKD
		case HRK
		case HUF
		case IDR
		case ILS
		case INR
		case ISK
		case JPY
		case KRW
		case MXN
		case MYR
		case NOK
		case NZD
		case PHP
		case PLN
		case RON
		case RUB
		case SEK
		case SGD
		case THB
		case TRY
		case USD
		case ZAR
		
		var countryName: String {
			switch self {
			case .EUR:
				return "European union"
			case .AUD:
				return "Australia"
			case .BGN:
				return "Bulgaria"
			case .BRL:
				return "Brazil"
			case .CAD:
				return "Canada"
			case .CHF:
				return "Switzerland"
			case .CNY:
				return "China"
			case .CZK:
				return "Czech Republic"
			case .DKK:
				return "Denmark"
			case .GBP:
				return "United Kingdom"
			case .HKD:
				return "Hong Kong"
			case .HRK:
				return "Croatia"
			case .HUF:
				return "Hungary"
			case .IDR:
				return "Indonesia"
			case .ILS:
				return "Israel"
			case .INR:
				return "India"
			case .ISK:
				return "Iceland"
			case .JPY:
				return "Japan"
			case .KRW:
				return "South Korea"
			case .MXN:
				return "Mexico"
			case .MYR:
				return "Malaysia"
			case .NOK:
				return "Norway"
			case .NZD:
				return "New Zealand"
			case .PHP:
				return "Philippines"
			case .PLN:
				return "Poland"
			case .RON:
				return "Romania"
			case .RUB:
				return "Russia"
			case .SEK:
				return "Sweden"
			case .SGD:
				return "Singapore"
			case .THB:
				return "Thailand"
			case .TRY:
				return "Turkey"
			case .USD:
				return "United States"
			case .ZAR:
				return "South Africa"
			}
		}
	}
	
}
