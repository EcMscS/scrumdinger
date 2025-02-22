/*
See LICENSE folder for this sample’s licensing information.
*/

import SwiftUI

public struct TrailingIconLabelStyle: LabelStyle {
    public func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.title
            configuration.icon
        }
    }
}

extension LabelStyle where Self == TrailingIconLabelStyle {
    public static var trailingIcon: Self { Self() }
}
