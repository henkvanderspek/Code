//
//  NewsView.swift
//  Code
//
//  Created by Henk van der Spek on 01/03/2022.
//

import SwiftUI

struct News {}

struct NewsView: View {
    var body: some View {
        VStack(alignment: .leading) {
            LiveHeaderView(
                viewModel: .init(
                    superTitle: "Updated 58 minutes ago",
                    title: "Live Updates: Ukrainians Flee as Russia Bombards Civilians",
                    body: "President Volodymyr Zelensky called on Monday for an international tribunal to investigate Russia for war crimes. Delegations from Kyiv and Moscow failed to make progress in Belarus.",
                    image: .init(
                        url: .init(string: "https://static01.nyt.com/images/2022/03/01/world/01ukraine-blog-kharkiv1/merlin_203029323_9f527873-3a3b-4b53-b35b-1c759bca62b9-jumbo.jpg?quality=75&auto=webp")!,
                        description: "The area near the regional administration building that was damaged by a missile in Kharkiv, Ukraine, on Tuesday.",
                        source: "Sergey Bobok/Agence France-Presse — Getty Images"
                    )
                )
            )
        }
    }
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView()
    }
}
