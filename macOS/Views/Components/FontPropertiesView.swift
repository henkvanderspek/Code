//
//  FontPropertiesView.swift
//  macOS
//
//  Created by Henk van der Spek on 17/05/2022.
//


import SwiftUI

struct FontPropertiesView: View {
    @Binding var model: Uicorn.Font
    var body: some View {
        Section {
            HGroup {
                VStack(alignment: .leading) {
                    Header("Type")
                    Picker("Type", selection: $model.type) {
                        ForEach(Uicorn.Font.allTypeCases, id: \.self) {
                            Text($0.localizedString)
                        }
                    }
                }
                VStack(alignment: .leading) {
                    Header("Weight")
                    Picker("Weight", selection: $model.weight) {
                        ForEach(Uicorn.Font.Weight.allCases, id: \.self) {
                            Text($0.localizedString)
                        }
                    }
                }
            }
            HGroup {
                VStack(alignment: .leading) {
                    Header("Design")
                    Picker("Design", selection: $model.design) {
                        ForEach(Uicorn.Font.Design.allCases, id: \.self) {
                            Text($0.localizedString)
                        }
                    }
                }
                GreedySpacer()
            }
        }
        .labelsHidden()
    }
}

struct FontPropertiesView_Previews: PreviewProvider {
    static var previews: some View {
        FontPropertiesView(model: .constant(.default))
    }
}
