//
//  TitleTextField.swift
//
//  Created by James Sedlacek on 2/21/25.
//

import SwiftUI

@MainActor
struct TitleTextField: View {
    @Binding var title: String

    var body: some View {
        TextField(.title, text: $title)
    }
}
