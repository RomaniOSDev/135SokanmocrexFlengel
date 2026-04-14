//
//  AppExternalLink.swift
//  135SokanmocrexFlengel
//

import UIKit

enum AppExternalLink: String {
    case privacyPolicy = "https://sokanmocrexflengel135.site/privacy/101"
    case termsOfUse = "https://sokanmocrexflengel135.site/terms/101"

    func open() {
        if let url = URL(string: rawValue) {
            UIApplication.shared.open(url)
        }
    }
}
