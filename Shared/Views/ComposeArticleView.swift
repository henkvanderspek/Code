//
//  ComposeArticleView.swift
//  Code
//
//  Created by Henk van der Spek on 18/03/2022.
//

import SwiftUI

struct ComposeArticleView: View {
    @Environment(\.navigationBarSettings.foregroundColor) private var foregroundColor
    @Environment(\.navigationBarSettings.backgroundColor) private var backgroundColor
    @Environment(\.dismiss) private var dismiss
    @State private var canPublish = false
    @State private var title = ""
    @State private var content = ""
    private var inputAccessoryView = UITextView()
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                ComposeTextView(content: $content, placeholder: "Title")
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationTitle("New Article")
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button("Cancel", role: .cancel) {
                                dismiss()
                            }
                            .tint(.teal)
                        }
                        ToolbarItemGroup(placement: .navigationBarTrailing) {
                            Button("Draft") {
                                canPublish = true
                            }
                            .tint(.teal)
                        }
                    }
                if canPublish {
                    Button {
                        print("foo")
                    } label: {
                        Label("Publish", systemImage: "paperplane.fill")
                            .padding()
                            .frame(maxWidth: .infinity)
                    }
                    .background(.yellow)
                    .tint(.black)
                }
            }
        }
    }
}

struct WriteView_Previews: PreviewProvider {
    static var previews: some View {
        ComposeArticleView()
    }
}
//
//class TextField: UITextField {
//    @Published var value: String?
//    override init(frame: CGRect = .zero) {
//        super.init(frame: frame)
//        delegate = self
//    }
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
//
//extension TextField: UITextFieldDelegate {
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        print(string)
//        value = string
//        return true
//    }
//}
