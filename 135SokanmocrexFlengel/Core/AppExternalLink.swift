//
//  AppExternalLink.swift
//  135SokanmocrexFlengel
//

import UIKit

enum AppExternalLink: String {
    case privacyPolicy = "https://example.com/privacy-policy"
    case termsOfUse = "https://example.com/terms"

    func open() {
        if let url = URL(string: rawValue) {
            UIApplication.shared.open(url)
        }
    }
}
