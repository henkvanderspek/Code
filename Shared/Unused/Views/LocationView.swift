//
//  LocationView.swift
//  Code
//
//  Created by Henk van der Spek on 15/03/2022.
//

import SwiftUI
import UniformTypeIdentifiers
import MapKit
import Contacts

struct LocationView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var image: Image?
    @State private var isShareVisible = false
    @State private var isSheetVisible = false
    private let data: Location
    init(_ d: Location) {
        data = d
    }
    var body: some View {
        GeometryReader { geo in
            HStack {
                if image == nil {
                    EmptyView()
                } else {
                    image?
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
                        .clipped()
                }
            }
            .task {
                image = try? await LocationFetcher(
                    .init(from: data.coordinate),
                    size: geo.size
                ).fetch().map { .init(nativeImage: $0) }
            }
            .id(colorScheme)
            .confirmationDialog("", isPresented: $isShareVisible, titleVisibility: .hidden) {
                Button("Share") {
                    isSheetVisible = true
                }
                Button("Open in Apple Maps") {
                    MKMapItem(placemark: .init(coordinate: .init(from: data.coordinate))).openInMaps(launchOptions: [:])
                }
            }
            .sheet(isPresented: $isSheetVisible) {
                ActivityView(activityItems: data.coordinate.activityItems ?? [])
            }
            .onTapGesture {
                isShareVisible = true
            }
        }
    }
}

extension Coordinate {
    var activityItems: [Any]? {
        guard let u = URL(string: "https://maps.apple.com?ll=\(latitude),\(longitude)") else { return nil }
        return [u]
    }
}

struct ActivityView: UIViewControllerRepresentable {
    let activityItems: [Any]
    func makeUIViewController(context: Context) -> UIActivityViewController {
        return .init(activityItems: activityItems, applicationActivities: nil)
    }
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}


extension CGSize {
    func padded(_ v: Int) -> Self {
        .init(width: width + (width * CGFloat(v)), height: height + (height * CGFloat(v)))
    }
}

struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationView(.mock)
    }
}

extension CLLocationCoordinate2D {
    init(from coordinate: Coordinate) {
        self.init(latitude: coordinate.latitude, longitude: coordinate.longitude)
    }
}

