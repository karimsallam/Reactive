import ReactiveSwift
import enum Result.NoError
import UIKit

extension Reactive where Base: UITextField {
	/// Sets the text of the text field.
	public var text: BindingTarget<String?> {
		return makeBindingTarget { $0.text = $1 }
	}

	/// A signal of text values emitted by the text field upon end of editing.
	public var textValues: Signal<String?, NoError> {
		return trigger(for: .editingDidEnd)
			.map { [unowned base = self.base] in base.text }
	}

	/// A signal of text values emitted by the text field upon any changes.
	public var continuousTextValues: Signal<String?, NoError> {
		return trigger(for: .editingChanged)
			.map { [unowned base = self.base] in base.text }
	}
}
