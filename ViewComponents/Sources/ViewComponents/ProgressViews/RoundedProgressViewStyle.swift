//
//  RoundedProgressViewStyle.swift
//
//  Created by James Sedlacek on 2/17/25.
//

import SwiftUI

public struct RoundedProgressViewStyle: ProgressViewStyle {
    private let backgroundColor: Color

    public init(
        background: Color
    ) {
        self.backgroundColor = background
    }

    public func makeBody(configuration: Configuration) -> some View {
        ProgressView(configuration)
            .frame(height: 12.0)
            .padding(.horizontal)
            .background(
                backgroundColor,
                in: .rect(cornerRadius: 10.0)
            )
            .frame(height: 20.0)
    }
}

extension ProgressViewStyle where Self == RoundedProgressViewStyle {
    public static func rounded(
        background: Color
    ) -> Self {
        Self(background: background)
    }
}

#Preview {
    ProgressView(value: 0.4)
        .tint(.blue)
        .progressViewStyle(
            .rounded(
                background: .gray.opacity(0.3)
            )
        )
}
