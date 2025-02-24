//
//  ErrorView.swift
//  MovieApp
//
//  Created by Ricardo Montesinos on 23/02/25.
//

import SwiftUI

struct ErrorView: View {
    let iconName: String
    let message: String
    let retryAction: () -> Void

    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: iconName)
                .resizable()
                .frame(width: 60, height: 60)
                .foregroundColor(.red)

            Text(message)
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            Button(action: retryAction) {
                Text("Retry")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            .padding(.horizontal, 40)
        }
        .padding()
    }
}
