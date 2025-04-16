//
//  ViewController.swift
//  SPMTestTvOS
//
//  Created by Andre Herculano on 14/4/25.
//

import UIKit
import ConsentViewControllerTvOS

class ViewController: UIViewController {
    lazy var consentManager: SPSDK = { SPConsentManagerTvOS(
        accountId: 22,
        propertyId: 17935,
        propertyName: try! SPPropertyName("appletv.demo"),
        campaigns: SPCampaigns(gdpr: SPCampaign()),
        delegate: self
    ) }()

    override func viewDidLoad() {
        super.viewDidLoad()
        let bundle = Bundle(for: SPConsentManagerTvOS.self)

        let frameworkBundle = Bundle(for: SPConsentManagerTvOS.self)
        let url = frameworkBundle.url(forResource: "ConsentViewController_ConsentViewControllerTvOS", withExtension: "bundle")!
        let resourceBundle = Bundle(url: url)!
        if let resourcePath = resourceBundle.resourcePath,
           let enumerator = FileManager.default.enumerator(atPath: resourcePath) {
            print("📦 All resources in bundle: \(bundle.bundleURL.lastPathComponent)")
            for case let file as String in enumerator {
                print("  • \(file)")
            }
        }

        consentManager.loadMessage(forAuthId: nil, pubData: nil)
    }
}

extension ViewController: SPDelegate {
    func onAction(_ action: SPAction, from controller: UIViewController) {
        print("onAction:", action)
    }

    func onSPUIReady(_ controller: UIViewController) {
        present(controller, animated: true)
    }

    func onSPUIFinished(_ controller: UIViewController) {
        dismiss(animated: true)
    }
}

