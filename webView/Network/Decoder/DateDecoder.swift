//
//  DateDecoder.swift
//  webView
//
//  Created by LKY on 14/01/21.
//

import Foundation

final class DateDecoder: JSONDecoder{
    let dateFormatter = DateFormatter()
    
    override init() {
        super.init()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXX"
        dateDecodingStrategy = .formatted(dateFormatter)
    }
}
