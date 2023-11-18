import ComposableArchitecture
import SwiftUI

@Reducer
struct SignInFeature {
    struct State: Equatable {
        @BindingState var focus: Field?
        
        @BindingState var email: String
        @BindingState var password: String
        
        enum Field: Hashable {
            case email
            case password
        }
        
        init(focus: Field? = .email, email: String = String(), password: String = String()) {
            self.focus = focus
            self.email = email
            self.password = password
        }
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case signInButtonTapped
        case onEmailSubmit
        case onPasswordSumbit
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case .binding:
                return .none
            case .onEmailSubmit:
                state.focus = .password
                return .none
            case .onPasswordSumbit:
                return .send(.signInButtonTapped)
            case .signInButtonTapped:
                state.password = String()
                state.email = String()
                state.focus = nil
                
                let credentials = SignInRequest(email: state.email, password: state.password)
                return .run { send in
                    try await Client.shared.signIn(with: credentials)
                }
            }
        }
    }
}

struct SignInView: View {
    @FocusState var focus: SignInFeature.State.Field?
    let store: StoreOf<SignInFeature>
    
    private let envelopeImage = Image(systemName: "envelope")
    
    var body : some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            VStack(alignment: .leading){
                FormTitleView(title: "Log in to", highlighted: "Susie")
                
                CustomTextField(title: "Email address", text: viewStore.$email, keyboard: .emailAddress, focusedField: $focus, equals: .email) { envelopeImage }
                    .onSubmit { viewStore.send(.onEmailSubmit) }
                
                Divider()
                
                PasswordField(title: "Password", text: viewStore.$password, focusedField: $focus, equals: .password)
                    .onSubmit { viewStore.send(.onPasswordSumbit) }
                
                Button("Sign in") {
                    viewStore.send(.signInButtonTapped)
                }
                .buttonStyle(.secondary)
                //TODO: Validate entered data bofore sending a network request

                Spacer()
            }
            .padding()
            .bind(viewStore.$focus, to: $focus)
        }
    }
}

#Preview {
    SignInView(store: Store(initialState: SignInFeature.State()) {
      SignInFeature()
            ._printChanges()
    })
}
