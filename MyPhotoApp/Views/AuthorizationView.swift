//
//  AuthorizationView.swift
//  MyPhotoApp
//
//  Created by Thiago Ramos on 04/07/20.
//  Copyright © 2020 Thiago Ramos. All rights reserved.
//

import Foundation
import SwiftUI

struct AuthorizationView: View {
    @State var email: String = ""
    @State var password: String = ""
    
    @ObservedObject var authorizationViewModel: AuthorizationViewModel
    
    init(authorizationViewModel: AuthorizationViewModel) {
        self.authorizationViewModel = authorizationViewModel
    }
        
    func login() {
        self.authorizationViewModel.login(email: email, password: password)
    }
        
    var body: some View {
        switch self.authorizationViewModel.viewState {
            case .notLoggedIn: return AnyView(loginView)
            case .loading: return AnyView(ActivityIndicatorView())
            case .loggedIn: return AnyView(FeedView(feedViewModel: FeedViewModel()))
            case .error: return AnyView(loginView)
        }
    }
    
    var loginView: some View {
        ZStack {
//            Image("cover")
//                .resizable()
//                .aspectRatio(contentMode: .fill)
//                .frame(width: screenSize().width, height: screenSize().height)
//                .blur(radius: 20)
            VStack {
                Text("My Photo App")
                    .font(Font.custom("Billabong", size: 40))
                    .border(Color.red)
                    .padding(.bottom, 40)
                VStack(alignment: .leading) {
                    TextField("Email Address", text: $email)
                        .autocapitalization(.none)
                        .keyboardType(.emailAddress)
                        .padding()
                        .font(.headline)
                        .background(Color("TextFieldColor"))
                        .border(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
                        .padding(.bottom)
                     
                    SecureField("Pasword", text: $password)
                        .padding()
                        .autocapitalization(.none)
                        .font(.headline)
                        .background(Color("TextFieldColor"))
                        .border(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
                        .padding(.bottom)
                }
                .padding()
                
                Button(action: {
                    self.login()
                }) {
                    Text("LOG IN")
                        .frame(minWidth: 100)
                        .padding(.leading, 100)
                        .padding(.trailing, 100)
                        .padding(.top)
                        .padding(.bottom)
                        .contentShape(Capsule())
                        .font(.headline)
                        .foregroundColor(.white)
                }
                .background(Color("LoginButtonColor"))
                .cornerRadius(10)
                
                if self.authorizationViewModel.errorMessage.count > 0 {
                    VStack(alignment: .center) {
                        Text("Error when logging you in")
                        Text(self.authorizationViewModel.errorMessage)
                    }
                    .padding()
                    .foregroundColor(.red)
                    .font(.headline)
                }
             }
            .offset(y: -screenSize().height / 6)
        }
        .blur(radius: self.authorizationViewModel.loading ? 20 : 0)
        .overlay(self.authorizationViewModel.loading ? ActivityIndicatorView() : nil)
    }
}

struct AuthorizationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthorizationView(authorizationViewModel: AuthorizationViewModel())
    }
}
