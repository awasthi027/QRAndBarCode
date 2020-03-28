//
//  QRData.swift
//  QAndBScanner
//
//  Created by Ashish Awasthi on 27/03/20.
//  Copyright © 2019 KM, Abhilash. All rights reserved.
//

import Foundation

struct QRData {
    var scannedStr: String
    init(with str: String) {
        self.scannedStr = str
    }
}
