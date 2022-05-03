//
//  ComposeTextView.swift
//  Code
//
//  Created by Henk van der Spek on 18/03/2022.
//

import SwiftUI
import UIKit

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
        return coordinator
    }
    func makeUIView(context: Context) -> UITextView {
        let v = context.coordinator
        v.autocorrectionType = .no
        v.spellCheckingType = .no
        v.textContainerInset = .all(16)
        v.allowsEditingTextAttributes = true
        v.becomeFirstResponder()
        return v
    }
    func updateUIView(_ uiView: UITextView, context: Context) {
    }
}

extension TextView {
    func font(_ f: UIFont) -> Self {
        coordinator.font = f
        coordinator.typingFont = f
        return self
    }
}

extension TextView {
    class InnerView: UITextView {
        // Make spacing, indent, tint color injectables
        @Binding var value: String
        private let paragraphSpacing: CGFloat = 16.0
        private let imageContainerHeight: CGFloat = 300.0
        private let uti = "public.text"
//        private var firstParagraphBreakIndex: Int?
        init(value v: Binding<String>) {
            _value = v
            super.init(frame: .zero, textContainer: nil)
            NSTextAttachment.registerViewProviderClass(ImageViewProvider.self, forFileType: uti)
            delegate = self
            layoutManager.delegate = self
            textStorage.delegate = self
            textContainer.lineFragmentPadding = 0
            tintColor = .systemTeal
            setMarkedText("Title", selectedRange: .init(location: 0, length: 0))
            let bar = UIToolbar()
            let reset = UIBarButtonItem(image: .init(systemName: "photo")?.withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(appendImage))
            bar.items = [.flexibleSpace(), reset]
            bar.tintColor = tintColor
            bar.sizeToFit()
            inputAccessoryView = bar
        }
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        override func caretRect(for position: UITextPosition) -> CGRect {
            let r = super.caretRect(for: position)
            let range = textRange(from: beginningOfDocument, to: position)
            let offset = offset(from: beginningOfDocument, to: position)
            //print(range)
            //print(offset)
//            let proposedHeight = r.height
//            let isFirstParagraph = r.minY == textContainerInset.top - 1
//            let f: UIFont = isFirstParagraph ? .title : .body
//            let lineHeight = f.lineHeight
//            let isImageContainer = proposedHeight >= imageContainerHeight
//            let h = isImageContainer ? imageContainerHeight : lineHeight
////            print("isFirstParagraph \(isFirstParagraph)")
////            print("caretHeight: \(h)")
////            print("proposedHeight: \(proposedHeight)")
////            print("lineHeight: \(lineHeight)")
////            print("fontPointSize: \(typingFont?.pointSize ?? 0)")
//            return .init(
//                origin: .init(
//                    x: r.minX,
//                    y: isFirstParagraph ? r.minY : r.minY + paragraphSpacing / 2.0
//                ),
//                size: .init(
//                    width: r.width,
//                    height: h
//                )
//            )
            return r
        }
        @objc private func appendImage() {
            setMarkedText(nil, selectedRange: .init())
            let a = NSTextAttachment(data: nil, ofType: uti)
            let s: CGSize = .init(width: bounds.width, height: imageContainerHeight)
            a.bounds = .init(origin: .zero, size: s)
            a.lineLayoutPadding = -textContainerInset.left
            var t = attributedText.mutableCopy() as! NSMutableAttributedString
            appendParagraph(to: &t)
            t.append(.init(attachment: a))
            appendParagraph(to: &t)
            attributedText = t
            print(t)
        }
        private func appendParagraph(to s: inout NSMutableAttributedString, skipIfEmpty: Bool = true) {
            guard s.length != 0 && skipIfEmpty else { return }
            s.append(.endOfParagraph)
            s.addAttributes([
                    .font: UIFont.preferredFont(forTextStyle: .body).withDesign(.serif),
                    .paragraphStyle: NSParagraphStyle.custom(spacing: paragraphSpacing)
                ],
                range: .init(location: s.length - 1, length: 1)
            )
        }
    }
}

extension TextView.InnerView: NSLayoutManagerDelegate {
//    func layoutManager(_ layoutManager: NSLayoutManager, shouldUse action: NSLayoutManager.ControlCharacterAction, forControlCharacterAt charIndex: Int) -> NSLayoutManager.ControlCharacterAction {
//        if action.contains(.paragraphBreak), action.contains(.lineBreak) {
//            firstParagraphBreakIndex = firstParagraphBreakIndex.map { min($0, charIndex) } ?? charIndex
//        }
//        print(#function)
//        print(firstParagraphBreakIndex)
//        return action
//    }
}

extension TextView.InnerView: NSTextStorageDelegate {
    func textStorage(_ textStorage: NSTextStorage, willProcessEditing editedMask: NSTextStorage.EditActions, range editedRange: NSRange, changeInLength delta: Int) {
        let text = textStorage.attributedSubstring(from: editedRange)
        print(editedRange)
        if editedMask.contains(.editedAttributes) {
            text.enumerateAttributes(in: editedRange, options: []) { a, _, _ in
                print(a)
            }
            print("Will process editing of attributes in \(text)")
        }
        if editedMask.contains(.editedCharacters) {
            print("Will process editing of characters in \(text)")
        }
//        let length = textStorage.length
//        textStorage.addAttributes([
//                .paragraphStyle: NSParagraphStyle.custom(spacing: paragraphSpacing),
//                .font: UIFont.title
//            ],
//            range: .init(location: 0, length: firstParagraphBreakIndex ?? length)
//        )
//        guard let index = firstParagraphBreakIndex else { return }
//        textStorage.addAttributes([
//                .paragraphStyle: NSParagraphStyle.custom(spacing: paragraphSpacing),
//                .font: UIFont.body
//            ],
//            range: .init(location: index, length: length - index)
//        )
    }
}

extension UIFont {
    var isHelvetica: Bool {
        return familyName == "Helvetica"
    }
}

extension TextView.InnerView: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        value = text
        if text == "\n" {
            var t = attributedText.mutableCopy() as! NSMutableAttributedString
            appendParagraph(to: &t)
            attributedText = t
            setMarkedText("Content", selectedRange: .init(location: 0, length: 0))
            //print(attributedText)
            return false
        }
        return true
    }
}

extension NSAttributedString {
    static var endOfParagraph: Self {
        .init(string: "\n")
    }
}

extension TextView.InnerView {
    class ImageViewProvider: NSTextAttachmentViewProvider {
        override func loadView() {
//            let label = UILabel()
//            label.text = "Test"
//            label.textAlignment = .center
//            view = label
            //view = CameraView(position: .back)
            //view?.isUserInteractionEnabled = false
//            let t = UITextField()
//            t.backgroundColor = .systemPink
//            t.textAlignment = .center
//            t.tintColor = .white
//            t.becomeFirstResponder()
//            view = t
            let v = UIView()
            v.backgroundColor = .systemPink
            view = v
        }
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
    var typingParagraphStyle: NSParagraphStyle? {
        return typingAttributes[.paragraphStyle] as? NSParagraphStyle
    }
}

extension UIFont {
    static var title: UIFont {
        .preferredFont(forTextStyle: .title1).withDesign(.serif)
    }
    static var body: UIFont {
        .preferredFont(forTextStyle: .body).withDesign(.serif)
    }
}

extension Dictionary where Key == NSAttributedString.Key, Value == Any {
    static func custom(paragraphSpacing: CGFloat) -> Self {[
        .font: UIFont.body,
        .paragraphStyle: NSParagraphStyle.custom(spacing: paragraphSpacing)
    ]}
}

extension UITextView {
    var textContainerWidth: CGFloat {
        bounds.width - textContainerInset.left - textContainerInset.right
    }
}

extension NSParagraphStyle {
    static func custom(spacing: CGFloat) -> NSParagraphStyle {
        let p = NSMutableParagraphStyle()
        p.setParagraphStyle(.default)
        p.paragraphSpacing = spacing / 2
        p.paragraphSpacingBefore = spacing / 2
        p.tailIndent = 0
        p.headIndent = 0
        p.firstLineHeadIndent = 0
        return p
    }
}

struct ComposeTextView_Previews: PreviewProvider {
    static var previews: some View {
        ComposeTextView(content: .constant(""), placeholder: "Title")
    }
}
