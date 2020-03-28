//
//  DetailsViewController.swift
//  QAndBScanner
//
//  Created by Ashish Awasthi on 27/03/20.
//  Copyright © 2020 Ashish Awasthi. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    @IBOutlet weak var detailLabel: CopyLabel!
    var qrData: QRData?
    
    static func detailsViewController() -> DetailsViewController? {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        return storyBoard.instantiateViewController(withIdentifier: String(describing: DetailsViewController.self)) as? DetailsViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailLabel.text = qrData?.scannedStr
        UIPasteboard.general.string = detailLabel.text
        showToast(message : "Text copied to clipboard")
    }
    
    @IBAction func openInWebAction(_ sender: Any) {
        if let url = URL(string: qrData?.scannedStr ?? ""), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:])
        } else {
            showToast(message : "Not a valid URL")
        }
    }
}
