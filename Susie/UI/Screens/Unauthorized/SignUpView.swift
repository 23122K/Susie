
import ComposableArchitecture
import SwiftUI

@Reducer
struct SignUpFeature {
    struct State: Equatable {
        @BindingState var focus: Field?
        
        @BindingState var firstName: String
        @BindingState var lastName: String
        @BindingState var email: String
        @BindingState var password: String
        @BindingState var confirmPassword: String
        @BindingState var isScrumMaster: Bool
        
        enum Field: Hashable {
            case firstName
            case lastName
            case email
            case password
            case confirmPassword
        }
        
        init(
            focus: Field? = .firstName,
            firstName: String = String(),
            lastName: String = String(),
            email: String = String(),
            password: String = String(),
            confirmPassword: String = String(),
            isScurmMaster: Bool = Bool()
        ){
            self.focus = focus
            self.firstName = firstName
            self.lastName = lastName
            self.email = email
            self.password = password
            self.confirmPassword = confirmPassword
            self.isScrumMaster = isScurmMaster
        }
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case onFirstNameSubmit
        case onLastNameSubmit
        case onEmailSubmit
        case onPasswordSubmit
        case onConfirmPasswordSubmit
        case onSignUpButtonTapped
        case nextButtonTapped
        
        case signUpRequestSent(SignUpRequest)
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case .nextButtonTapped:
                return .none
            case .onSignUpButtonTapped:
                let credentials = SignUpRequest(firstName: state.firstName, lastName: state.lastName, email: state.email, password: state.password)
                return .send(.signUpRequestSent(credentials))
            case .onFirstNameSubmit:
                state.focus = .lastName
                return .none
            case .onLastNameSubmit:
                state.focus = .email
                return .none
            case .onEmailSubmit:
                state.focus = .password
                return .none
            case .onPasswordSubmit:
                state.focus = .confirmPassword
                return .none
            case .onConfirmPasswordSubmit:
                state.focus = nil
                return .send(.onSignUpButtonTapped)
            case .binding:
                return .none
            case .signUpRequestSent:
                return .none
            }
        }
    }
}

struct SignUpView: View {
    @FocusState var focus: SignUpFeature.State.Field?
    let store: StoreOf<SignUpFeature>
    
    private let personImage = Image(systemName: "person")
    private let envelopeImage = Image(systemName: "envelope")

    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            VStack(alignment: .leading) {
                VStack(alignment: .leading){
                    FormTitleView(title: "Create your", highlighted: "accout")
                    
                    CustomTextField(title: "First name", text: viewStore.$firstName, keyboard: .default, focusedField: $focus, equals: .firstName) { personImage }
                        .onSubmit { viewStore.send(.onFirstNameSubmit) }
                    
                    Divider()
                    
                    CustomTextField(title: "Last name", text: viewStore.$lastName, keyboard: .default, focusedField: $focus, equals: .lastName) { personImage }
                        .onSubmit { viewStore.send(.onLastNameSubmit) }
                    
                    Divider()
                    
                    CustomTextField(title: "Email address", text: viewStore.$email, keyboard: .emailAddress, focusedField: $focus, equals: .email) { envelopeImage }
                        .onSubmit { viewStore.send(.onEmailSubmit) }
                    
                }
                .padding()
                
                //TODO: Validate before continuing
                Button("Next") {
                    viewStore.send(.nextButtonTapped)
                }
                .buttonStyle(.secondary)
                
                Spacer()
                
                Checkbox(title: "Register as a scrum master", isSelected: viewStore.$isScrumMaster)
                    .padding()
            }
            .bind(viewStore.$focus, to: $focus)
        }
    }
}

#Preview {
    SignUpView(store: Store(initialState: SignUpFeature.State()) {
        SignUpFeature()
            ._printChanges()
    })
}
