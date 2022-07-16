//
//  UnityInterface.swift
//  
//
//  Created by fuziki on 2022/07/16.
//

import Foundation

@_cdecl("AppEventMonitor_Start")
public func AppEventMonitor_Start(_ configStrPtr: UnsafePointer<CChar>?,
                                  _ handler: @escaping @convention(c) (UnsafePointer<CChar>) -> Void) {
    let configStr = String(cString: configStrPtr!)
    UnityAppEventMonitor.shared.start(configuration: configStr) { (resStr: String) in
        let resNsStr = resStr as NSString
        let resNsStrPtr: UnsafePointer<CChar> = resNsStr.utf8String!
        let resNsStrPtrDup: UnsafeMutablePointer<CChar> = strdup(resNsStrPtr)
        handler(resNsStrPtrDup)
    }
}

@_cdecl("AppEventMonitor_Stop")
public func AppEventMonitor_Stop() {
    UnityAppEventMonitor.shared.stop()
}
