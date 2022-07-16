//
//  UnityInterface.swift
//
//
//  Created by fuziki on 2022/07/16.
//

import AppKit
import Foundation

public struct UnityAppEventMonitorConfiguration: Decodable {
    public let targets: UInt64
}

public struct UnityAppEventMonitorEvent: Encodable {
    public let characters: String
}

public class UnityAppEventMonitor {
    public static let shared = UnityAppEventMonitor()

    private var handler: ((String) -> Void)?
    private var eventMonitor: Any?

    private init() {
    }

    public func start(configuration: String,
                      handler: @escaping (String) -> Void) {
        stop()
        guard let data = configuration.data(using: .utf8),
              let config = try? JSONDecoder().decode(UnityAppEventMonitorConfiguration.self, from: data) else {
            return
        }
        self.handler = handler
        let mask = NSEvent.EventTypeMask(rawValue: config.targets)
        addGlobalMonitor(matching: mask)
    }

    private func addGlobalMonitor(matching mask: NSEvent.EventTypeMask) {
        eventMonitor = NSEvent.addGlobalMonitorForEvents(matching: mask) { [weak self] (event: NSEvent) in
            let res = UnityAppEventMonitorEvent(characters: event.characters ?? "")
            guard let data = try? JSONEncoder().encode(res),
                  let str = String(data: data, encoding: .utf8) else {
                return
            }
            self?.handler?(str)
        }
    }

    public func stop() {
        if let eventMonitor = eventMonitor {
            NSEvent.removeMonitor(eventMonitor)
        }
        handler = nil
        eventMonitor = nil
    }
}
