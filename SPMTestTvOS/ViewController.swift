//
//  ViewController.swift
//  SPMTestTvOS
//
//  Created by Andre Herculano on 14/4/25.
//

import UIKit
import ConsentViewControllerTvOS

class ViewController: UIViewController {

    /**
     This uses a "wrapper" around `SPConsentManager`. That wrapper behaves exactly like the original class
     but, has code to at runtime define the bundle where tvOS should look for the VCs XIBs.
     */
    lazy var consentManager: SPSDK = { SPConsentManagerTvOS(
        accountId: 22,
        propertyId: 17935,
        propertyName: try! SPPropertyName("appletv.demo"),
        campaigns: SPCampaigns(gdpr: SPCampaign()),
        delegate: self
    ) }()

    /**
     This uses the "original" `SPConsentManager`, without that wrapping logic mentioned above.
     */
//    lazy var consentManager: SPSDK = { SPConsentManager(
//        accountId: 22,
//        propertyId: 17935,
//        propertyName: try! SPPropertyName("appletv.demo"),
//        campaigns: SPCampaigns(gdpr: SPCampaign()),
//        delegate: self
//    ) }()

    override func viewDidLoad() {
        super.viewDidLoad()
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

