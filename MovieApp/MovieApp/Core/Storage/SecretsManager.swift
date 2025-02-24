//
//  LocalStorageManager..swift
//  MovieApp
//
//  Created by Ricardo Montesinos on 23/02/25.
//

import Foundation

struct SecretsManager {

    private static var secrets: [String: Any]? {
        guard let url = Bundle.main.url(forResource: "Secrets", withExtension: "plist") else {
            print("Secrets.plist not found in bundle.")
            return nil
        }
        
        do {
            let data = try Data(contentsOf: url)
            let plist = try PropertyListSerialization.propertyList(from: data, options: [], format: nil)
            if let dict = plist as? [String: Any] {
                print("Successfully loaded Secrets.plist")
                return dict
            } else {
                print("Secrets.plist format is invalid.")
            }
        } catch {
            print("Error reading Secrets.plist: \(error)")
        }
        return nil
    }

    static var apiKey: String {
        secrets?["API_KEY"] as? String ?? {
            print("API_KEY not found in Secrets.plist")
            return ""
        }()
    }

    static var accessToken: String {
        secrets?["ACCESS_TOKEN"] as? String ?? {
            print("ACCESS_TOKEN not found in Secrets.plist")
            return ""
        }()
    }
}
