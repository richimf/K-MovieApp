//
//  LanguageUtility.swift
//  MovieApp
//
//  Created by Ricardo Montesinos on 24/02/25.
//

import Foundation

class LanguageUtility {
    static func getDeviceAPILanguage() -> APILanguage {
        let languageCode = Locale.current.language.languageCode?.identifier ?? "en"
        
        switch languageCode {
        case "es":
            return .ES
        default:
            return .EN
        }
    }
}
