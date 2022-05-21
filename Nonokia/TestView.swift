//
//  TestView.swift
//  Nonokia
//
//  Created by Henk van der Spek on 21/05/2022.
//

import SwiftUI

class TestState: ObservableObject {
    @Published var shouldPresentPopover: Bool = false
}

struct TestView: View {
    @ObservedObject var state: TestState
    init(_ s: TestState) {
        state = s
    }
    @State private var scale = 0.5
    @State private var presentPopover = false
    var body: some View {
        VStack(spacing: 20) {
            if !state.shouldPresentPopover {
                Rectangle()
                    .fill(.pink)
                    .scaleEffect(scale)
                    .animation(.linear(duration: 1).repeatForever(), value: scale)
                    .onAppear { scale = 1.0 }
                    .onDisappear { scale = 0.5 }
                Text("Hello, World!")
                    .font(.system(.title, design: .default))
                    .fontWeight(.black)
                Text("🤓👍")
                    .font(.largeTitle)
                    .fontWeight(.black)
            } else if presentPopover {
                VStack(spacing: 20) {
                    Spacer()
                    Text("Bye, World!")
                        .font(.system(.title, design: .default))
                        .fontWeight(.black)
                    Text("👋🤓")
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                .transition(.move(edge: .top))
                .onDisappear { presentPopover = false }
            } else {
                Spacer()
                    .onAppear {
                        withAnimation {
                            presentPopover = true
                        }
                    }
            }
        }
        .padding()
        .background(.background)
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView(.init())
    }
}

class TestViewController: UIHostingController<TestView> {
    private var state = TestState()
    init() {
        super.init(rootView: .init(state))
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func toggleShouldPresentPover() {
        state.shouldPresentPopover.toggle()
    }
}
