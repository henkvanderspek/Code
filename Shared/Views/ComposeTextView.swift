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
        coordinator.paragraphSpacing = 32
        coordinator.imageContainerHeight = 300
    }
    func makeCoordinator() -> InnerView {
        return coordinator
    }
    func makeUIView(context: Context) -> UITextView {
        let v = context.coordinator
        v.autocorrectionType = .no
        v.spellCheckingType = .no
        v.textContainerInset = .vertical(16)
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
        private let uti = "public.text"
        init(value v: Binding<String>) {
            _value = v
            super.init(frame: .zero, textContainer: nil)
            delegate = self
            layoutManager.delegate = self
            textContainer.lineFragmentPadding = 0
            NSTextAttachment.registerViewProviderClass(ImageViewProvider.self, forFileType: uti)
        }
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        override func caretRect(for position: UITextPosition) -> CGRect {
            let r = super.caretRect(for: position)
            // TODO: Fix magic numbers
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

extension TextView.InnerView: NSLayoutManagerDelegate {}

extension TextView.InnerView: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        value = text
        if text == "\n" {
            let a = NSTextAttachment(data: nil, ofType: uti)
            a.bounds = .init(
                origin: .zero,
                size: .init(
                    width: bounds.width,
                    height: imageContainerHeight
                )
            )
            let t = attributedText.mutableCopy() as! NSMutableAttributedString
            let loc = t.length + 1
            t.append(.init(string: "\n"))
            t.append(.init(attachment: a))
            t.addAttributes([
                    .font: UIFont.preferredFont(forTextStyle: .body).withDesign(.serif),
                    .paragraphStyle: NSParagraphStyle.custom(spacing: paragraphSpacing, indent: 0)
                ],
                range: .init(location: loc, length: t.length - loc)
            )
            attributedText = t
            //print(attributedText)
            return false
        }
        return true
    }
}

extension TextView.InnerView {
    class ImageViewProvider: NSTextAttachmentViewProvider {
        override func loadView() {
//            let label = UILabel()
//            label.text = "Test"
//            label.textAlignment = .center
//            view = label
            view = CameraView(position: .back)
            view?.isUserInteractionEnabled = false
        }
    }
}

extension NSParagraphStyle {
    static func custom(spacing: CGFloat, indent: CGFloat = 16.0) -> NSParagraphStyle {
        let p = NSMutableParagraphStyle()
        p.setParagraphStyle(.default)
        p.paragraphSpacing = spacing / 2
        p.paragraphSpacingBefore = spacing / 2
        p.firstLineHeadIndent = indent
        p.headIndent = indent
        p.tailIndent = -indent
        return p
    }
}

extension TextView.InnerView {
    var typingFont: UIFont? {
        set {
            var a = typingAttributes
            a[.font] = newValue
            a[.paragraphStyle] = NSParagraphStyle.custom(spacing: paragraphSpacing)
            typingAttributes = a
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
