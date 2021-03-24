//
//  Task+helper.swift
//  SwiftUITaskAppV2
//
//  Created by Paul Franco on 3/24/21.
//

import Foundation
import CoreData

extension Task {
    
    var content: String {
        get {
            return content_ ?? ""
        }
        set {
            content_ = newValue
        }
    }
    
    var date: Date {
        get {
            return date_ ?? Date()
        }
        set {
            date_ = newValue
        }
    }
}
