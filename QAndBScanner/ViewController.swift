//
//  ViewController.swift
//  QAndBScanner
//
//  Created by Ashish Awasthi on 27/03/20.
//  Copyright © 2020 Ashish Awasthi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var scannerView: QRAndBarCodeScannerView! {
        didSet {
            scannerView.delegate = self
        }
    }
    
    @IBOutlet weak var scanBtn: UIButton! {
        didSet {
            scanBtn.setTitle("STOP", for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Harman QR and Barcode Scanner"
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !scannerView.isRunning {
            scannerView.startScanning()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if !scannerView.isRunning {
            scannerView.stopScanning()
        }
    }
    
    @IBAction func scanButtonAction(_ sender: UIButton) {
        scannerView.isRunning ? scannerView.stopScanning() : scannerView.startScanning()
        let buttonTitle = scannerView.isRunning ? "STOP" : "SCAN"
        sender.setTitle(buttonTitle, for: .normal)
    }
    
    func displayScanResultMessage(message: String) {
        let alertViewController = UIAlertController.init(title: "Scan Response", message: message, preferredStyle: .actionSheet)
        let navigate = UIAlertAction.init(title: "Details", style: .default) { (alert) in
            self.scannerView.stopScanning()
            if let item = DetailsViewController.detailsViewController() {
                item.qrData = QRData.init(with: message)
                self.navigationController?.pushViewController(item, animated: true)
            }
            alertViewController.dismiss(animated: true) {
            }
        }
        alertViewController.addAction(navigate)
        self.present(alertViewController, animated: true) {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 10) {
                alertViewController.dismiss(animated: true) {
                }
            }
        }
    }
}

extension ViewController: QRAndBarCodeScannerViewDelegate {
    func scannerView(_ view: QRAndBarCodeScannerView, didFailToScan message: String) {
        self.displayScanResultMessage(message: message)
    }
    func scannerView(_ view: QRAndBarCodeScannerView, didScanCodeSuccessfully scanCode: String) {
        self.displayScanResultMessage(message: "Scanned Code is:- " + scanCode)
    }
    func scannerView(_ view: QRAndBarCodeScannerView, didStopScanning message: String) {
       // self.displayScanResultMessage(message: message)
    }
}
