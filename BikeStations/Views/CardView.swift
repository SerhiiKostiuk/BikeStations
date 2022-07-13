//
//  CardView.swift
//  BikeStations
//
//  Created by skostiuk on 13.07.2022.
//

import SwiftUI

struct CardView: View {

    //MARK: - @State Properties

    @StateObject private var viewModel = CardViewModel()

    //MARK: - Private Property
    private let model: StationDTO

    //MARK: - Initializer
    init(model: StationDTO) {
        self.model = model
    }

    //MARK: - Body
    var body: some View {
        VStack(spacing: 20) {
            VStack(spacing: 0) {
                Text(model.properties.label)
                    .foregroundColor(Color.black)
                    .font(Font.title.bold())
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)

                Group {
                    Text("\(viewModel.distance ?? 0)m").foregroundColor(Color.gray) +
                    Text(" ܁ Bike Station").foregroundColor(Color.black)
                }
                .font(Font.system(size: 13, weight: .light, design: .default))
                .frame(maxWidth: .infinity, alignment: .leading)

            }
            HStack {
                VStack {
                    Image("Bike")
                    Text("Available bikes")
                        .foregroundColor(Color.gray)
                    Text(model.properties.freeRacks)
                        .font(Font.system(size: 40, weight: .bold, design: .default))
                        .foregroundColor(Color(hex: "9ADBB3"))

                }
                .frame(maxWidth: .infinity, alignment: .center)

                VStack {
                    Image("Lock")
                    Text("Available place")
                        .foregroundColor(Color.gray)
                    Text(model.properties.bikeRacks)
                        .font(Font.system(size: 40, weight: .bold, design: .default))
                        .foregroundColor(.black)

                }
                .frame(maxWidth: .infinity, alignment: .center)
            }

        }
        .onAppear {
            viewModel.getDistance(to: model.geometry.coordinates)
        }
        .onDisappear {
            viewModel.invalidate()
        }
    }
}
