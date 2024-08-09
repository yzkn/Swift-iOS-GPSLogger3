//
//  ContentView.swift
//  GPSLogger3
//
//  Created by Yu on 2024/08/02.
//

import SwiftUI
import CoreLocationUI

struct ContentView: View {
    var body: some View {
        VStack {
            LocationButton {
                debugPrint("LocationButton")
            }
            .foregroundColor(.white)
            .labelStyle(.iconOnly)
            .cornerRadius(30)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
