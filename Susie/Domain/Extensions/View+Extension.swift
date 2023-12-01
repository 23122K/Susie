import SwiftUI

extension View {
  /// Synchronizes model state to view state via two-way bindings.
  ///
  /// SwiftUI comes with many property wrappers that can be used in views to drive view state,
  /// like field focus. Unfortunately, these property wrappers _must_ be used in views. It's not
  /// possible to extract this logic to an `@Observable` class and integrate it with the rest of
  /// the model's business logic, and be in a better position to test this state.
  ///
  /// We can work around these limitations by introducing a published field to your observable
  /// object and synchronizing it to view state with this view modifier.
  ///
  /// - Parameters:
  ///   - modelValue: A binding from model state. _E.g._, a binding derived from a field
  ///     on an observable class.
  ///   - viewValue: A binding from view state. _E.g._, a focus binding.
  public func bind<ModelValue: _Bindable, ViewValue: _Bindable>(_ modelValue: ModelValue, to viewValue: ViewValue) -> some View
  where ModelValue.Value == ViewValue.Value, ModelValue.Value: Equatable {
    self.modifier(_Bind(modelValue: modelValue, viewValue: viewValue))
  }
}

private struct _Bind<ModelValue: _Bindable, ViewValue: _Bindable>: ViewModifier where ModelValue.Value == ViewValue.Value, ModelValue.Value: Equatable {
  let modelValue: ModelValue
  let viewValue: ViewValue

  @State var hasAppeared = false

  func body(content: Content) -> some View {
    content
      .onAppear {
        guard !self.hasAppeared else { return }
        self.hasAppeared = true
        guard self.viewValue.wrappedValue != self.modelValue.wrappedValue else { return }
        self.viewValue.wrappedValue = self.modelValue.wrappedValue
      }
      .onChange(of: self.modelValue.wrappedValue) {
        guard self.viewValue.wrappedValue != $0
        else { return }
        self.viewValue.wrappedValue = $0
      }
      .onChange(of: self.viewValue.wrappedValue) {
        guard self.modelValue.wrappedValue != $0
        else { return }
        self.modelValue.wrappedValue = $0
      }
  }
}

public protocol _Bindable {
  associatedtype Value
  var wrappedValue: Value { get nonmutating set }
}

extension AccessibilityFocusState: _Bindable {}
extension AccessibilityFocusState.Binding: _Bindable {}
extension Binding: _Bindable {}
extension FocusedBinding: _Bindable {}
extension FocusState: _Bindable {}
extension FocusState.Binding: _Bindable {}
extension SceneStorage: _Bindable {}
extension State: _Bindable {}
