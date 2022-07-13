//
//  StationDetailView.swift
//  BikeStations
//
//  Created by skostiuk on 13.07.2022.
//


import SwiftUI
import MapKit

struct Location: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}

struct StationDetailView: View {

    // MARK: - @Environment
    @Environment(\.presentationMode) var presentationMode

    // MARK: - @State
    @State private var mapRegion: MKCoordinateRegion

    //MARK: - Private Property
    private let model: StationDTO
    private let locations: [Location]

    //MARK: - Initializer
    init(model: StationDTO) {
        self.model = model
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: model.geometry.coordinates.first!, longitude: model.geometry.coordinates.last!), span: MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001))
        self._mapRegion = State(initialValue: region)
        self.locations = [Location(name: "", coordinate: CLLocationCoordinate2D(latitude: model.geometry.coordinates.first!, longitude: model.geometry.coordinates.last!))]
    }

    //MARK: - Body

    var body: some View {
        VStack(spacing: 20) {
            Map(coordinateRegion: $mapRegion, interactionModes: .all, showsUserLocation: true, annotationItems: locations) { location in
                MapAnnotation(coordinate: location.coordinate) {

                    HStack(spacing: 10) {
                        Image("Bike")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .padding(.all, 5)
                            .background(Circle().fill(Color.white))

                        Text(model.properties.freeRacks)
                            .font(Font.system(size: 25, weight: .bold, design: .default))
                            .foregroundColor(Color(hex: "9ADBB3"))
                            .padding(.top, 2)
                    }
                }
            }
            CardView(model: model).padding(.horizontal, 24)
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    VStack {
                        Image("Arrow")
                            .resizable()
                            .foregroundColor(Color.white)
                            .frame(width: 25, height: 25)
                    }.frame(width: 40, height: 40)


                }
            }
        }
        .overlay(
            Color.black
                .frame(height: (UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0))
                .ignoresSafeArea(.all, edges: .top), alignment: .top)
    }
}
