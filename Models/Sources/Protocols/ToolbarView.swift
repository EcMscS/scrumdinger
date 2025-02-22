//
//  ToolbarView.swift
//
//
//  Created by James Sedlacek on 5/24/24.
//

import SwiftUI

public protocol ToolbarView {
    associatedtype Content: ToolbarContent

    @MainActor
    @ToolbarContentBuilder
    func toolbarContent() -> Content
}
