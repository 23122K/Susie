//
//  SignUpFinalisationView.swift
//  Susie
//
//  Created by Patryk Maciąg on 16/05/2023.
//

import ComposableArchitecture
import SwiftUI

struct SignUpFinalisationView: View {
    @FocusState private var focus: SignUpFeature.State.Field?
    let store: StoreOf<SignUpFeature>
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            VStack(alignment: .leading){
                FormTitleView(title: "Create", highlighted: "password")
                PasswordField(title: "Password", text: viewStore.$password, focusedField: $focus, equals: .password)
                    .onSubmit { viewStore.send(.onPasswordSubmit) }
                
                Divider()
                
                PasswordField(title: "Confirm password", text: viewStore.$confirmPassword, focusedField: $focus, equals: .confirmPassword)
                  .onSubmit { viewStore.send(.onConfirmPasswordSubmit) }
                
                //TODO: Validate that passwords match and match given requirements
                Button("Sign up") {
                    viewStore.send(.onSignUpButtonTapped)
                }
                .buttonStyle(.secondary)
                
                Spacer()
            }
            .bind(viewStore.$focus, to: $focus)
            .padding()
        }
    }
    
}

#Preview {
    SignUpFinalisationView(store: Store(initialState: SignUpFeature.State()) {
        SignUpFeature()
    })
}
