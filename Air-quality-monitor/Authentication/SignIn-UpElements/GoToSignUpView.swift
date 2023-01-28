//
//  GoToSignUpView.swift
//  Air-quality-monitor
//
//  Created by Pietro Ballarin on 21.12.22.
//

import SwiftUI

struct GoToSignUpView: View {
    
    @ObservedObject var sessionManager: SessionManager
    var size: CGSize
    
    var body: some View {
        HStack {
            Text("Don't have an account?")
                .font(.headlineH3)
            Button(action: {
                self.showSignUpScreen()
            }) {
                Text("Sign Up")
                    .font(.headlineH3)
                    .foregroundColor(.green)
            }
        }
        .frame(width: size.width, height: size.height * 0.33, alignment: .center)
        .padding(.bottom)
    }
}

extension GoToSignUpView {
    func showSignUpScreen() {
        sessionManager.appState = .signinUp
    }
}

struct GoToSignUpView_Previews: PreviewProvider {
    static var previews: some View {
        GoToSignUpView(sessionManager: SessionManager(), size: CGSize(width: 500, height: 100))
    }
}
