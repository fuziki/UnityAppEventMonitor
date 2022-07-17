//
//  ContentViewModel.swift
//  NativeExample
//
//  Created by fuziki on 2022/07/17.
//

import Foundation
import SwiftUI
import UnityAppEventMonitor

class ContentViewModel: ObservableObject {
    static var shared = ContentViewModel()

    @Published var event: String = "no event"
    func start() {
        AppEventMonitor_Start("{ \"targets\" : 1024 }") { (ptr: UnsafePointer<CChar>) in
            let str = String(cString: ptr)
            ContentViewModel.shared.event = str
        }
    }
    func stop() {
        AppEventMonitor_Stop()
    }
}
