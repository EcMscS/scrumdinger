//
//  ViewLifecycle.swift
//
//  Created by James Sedlacek on 11/8/24.
//

@MainActor
public protocol ViewLifecycle {
    func onTask() async
    func onAppear()
    func onDisappear()
}

extension ViewLifecycle {
    public func onTask() async {}
    public func onAppear() {}
    public func onDisappear() {}
}
