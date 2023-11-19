
import ComposableArchitecture
import SwiftUI

@Reducer
struct WelcomeFeature {
    struct State: Equatable { }
    
    enum Action {
        case signInButtonTapped
        case signUpButtonTapped
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .signInButtonTapped, .signUpButtonTapped:
                return .none
            }
        }
    }
}

struct WelcomeView: View {
    let store: StoreOf<WelcomeFeature>
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { vs in
            ScrollView{
                VStack{
                    UserGreetingMessange()
                    
                    Button("Sign in") {
                        vs.send(.signInButtonTapped)
                    }
                    .buttonStyle(.primary)
                                   
                    CustomDivider()
                        .padding(.vertical,1)
                    
                    Button("Let's get started") {
                        vs.send(.signUpButtonTapped)
                    }
                    .buttonStyle(.primary)
                    
                    TermsOfService()
                }
            }
        }
    }
}

#Preview {
    WelcomeView(store: Store(initialState: WelcomeFeature.State()) {
        WelcomeFeature()
    })
}

