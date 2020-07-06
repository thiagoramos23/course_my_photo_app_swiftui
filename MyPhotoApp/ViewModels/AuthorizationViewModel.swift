//
//  AuthorizationViewModel.swift
//  MyPhotoApp
//
//  Created by Thiago Ramos on 04/07/20.
//  Copyright © 2020 Thiago Ramos. All rights reserved.
//

import Foundation
import Combine

enum AuthorizationState {
    case notLoggedIn, loading, loggedIn, error
}

class AuthorizationViewModel: ObservableObject {
    @Published var loading: Bool = false
    @Published var loggedIn: Bool = false
    @Published var viewState: AuthorizationState = .notLoggedIn
    @Published var errorMessage: String = ""

    var loginRepository: LoginRepository
    
    var cancellable: AnyCancellable?
    
    init() {
        self.loginRepository = LoginRepository()
    }
    
    deinit {
        cancellable?.cancel()
    }
    
    func login(email: String, password: String) {
        if email.isEmpty || password.isEmpty {
            DispatchQueue.main.async {
                self.errorMessage = "Please, inform email and password"
                self.viewState    = .error
            }
            return
        }
        
        DispatchQueue.main.async {
            self.viewState = .loading
        }
        
        cancellable = self.loginRepository
            .login(email: email, password: password)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    DispatchQueue.main.async {
                        self.viewState = .loggedIn
                    }
                    break
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.viewState = .error
                        switch error {
                        case .invalid(let errorMessage):
                            self.errorMessage = errorMessage
                            break
                        case .genericError(let errorMessage):
                            self.errorMessage = errorMessage
                            break
                        case.encodingError:
                            self.errorMessage = "Error when encoding. Check this error."
                            break
                        }
                    }
                    break
                }
            }) { account in
                account.storeAccount()
            }
    }
}
