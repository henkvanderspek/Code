//
//  ComposeTextView.swift
//  Code
//
//  Created by Henk van der Spek on 18/03/2022.
//

import SwiftUI

struct ComposeTextView: View {
    @Binding private var content: String
    private let placeholder: String
    init(content c: Binding<String>, placeholder p: String) {
        _content = c
        placeholder = p
    }
    var body: some View {
        TextView(text: $content)
            .font(.preferredFont(forTextStyle: .title1).withDesign(.serif))
    }
}

struct TextView: UIViewRepresentable {
    private let coordinator: InnerView
    init(text: Binding<String>) {
        coordinator = InnerView(value: text)
    }
    func makeCoordinator() -> InnerView {
        coordinator.paragraphSpacing = 32
        coordinator.imageContainerHeight = 300
        return coordinator
    }
    func makeUIView(context: Context) -> UITextView {
        let v = context.coordinator
        v.autocorrectionType = .no
        v.spellCheckingType = .no
        v.textContainerInset = .all(16)
        v.becomeFirstResponder()
        return v
    }
    func updateUIView(_ uiView: UITextView, context: Context) {
    }
}

extension TextView {
    func font(_ f: UIFont) -> Self {
        coordinator.typingFont = f
        return self
    }
}

extension TextView {
    class InnerView: UITextView {
        @Binding var value: String
        var paragraphSpacing: CGFloat = 0.0
        var imageContainerHeight: CGFloat = 0.0
        init(value v: Binding<String>) {
            _value = v
            super.init(frame: .zero, textContainer: nil)
            delegate = self
            layoutManager.delegate = self
        }
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        override func caretRect(for position: UITextPosition) -> CGRect {
            let r = super.caretRect(for: position)
            print(r.height)
            print(textRange(from: position, to: position))
            let height = r.height < imageContainerHeight ? ((typingFont?.lineHeight ?? 0.0) + 2.0).rounded(.toNearestOrEven) + 0.5 : r.height
            return .init(
                origin: r.origin,
                size: .init(
                    width: r.width,
                    height: height
                )
            )
        }
    }
}

extension TextView.InnerView: NSLayoutManagerDelegate {
    func layoutManager(_ layoutManager: NSLayoutManager, paragraphSpacingAfterGlyphAt glyphIndex: Int, withProposedLineFragmentRect rect: CGRect) -> CGFloat {
        typingFont = .preferredFont(forTextStyle: .body).withDesign(.serif)
        return paragraphSpacing
    }
}

extension TextView.InnerView: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        value = text
        if text == "\n" {
            let w = bounds.width - textContainerInset.left - textContainerInset.right
            let a = NSTextAttachment()
            a.image = .init(systemName: "mustache")!
            a.bounds = .init(origin: .zero, size: .init(width: w, height: imageContainerHeight))
            let s = NSMutableAttributedString(attachment: a)
            textStorage.append(s)
        } else {
            print(text)
        }
        return true
    }
}

extension TextView.InnerView {
    var typingFont: UIFont? {
        set {
            typingAttributes = typingAttributes.merging([.font: newValue as Any], uniquingKeysWith: { lhs, rhs in return rhs })
        }
        get {
            return typingAttributes[.font] as? UIFont
        }
    }
}

struct ComposeTextView_Previews: PreviewProvider {
    static var previews: some View {
        ComposeTextView(content: .constant(""), placeholder: "Title")
    }
}
