import SwiftUI

struct FormButtonStyle: ButtonStyle {
    private let isEmpty: Bool
        
    init(isEmpty: Bool) {
        self.isEmpty = isEmpty
    }
    
    func makeBody(configuration: Configuration) -> some View {
        let button = configuration.label
            .foregroundColor(.white)
            .fontWeight(.bold)
            .padding(.vertical)
            .frame(width: UIScreen.main.bounds.width - 100)
            
        let background = button.background(
            isEmpty ? (Color.gray.opacity(0.7)) : (Color.blue.opacity(configuration.isPressed ? 0.5 : 0.7))
        ).cornerRadius(25)
        .frame(width: 200, height: 50) // fixed size
            
        return background
            .shadow(color: Color.gray.opacity(0.4), radius: 16)
    }
}

