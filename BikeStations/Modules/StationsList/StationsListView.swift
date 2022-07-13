//
//  StationsListView.swift
//  BikeStations
//
//  Created by skostiuk on 13.07.2022.
//

import SwiftUI

struct StationsListView: View {

    //MARK: - @StateObject
    @ObservedObject private var viewModel = StationsListViewModel()

    //MARK: - Initializer
    init() {
        UINavigationBar.appearance().backgroundColor = .black
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
    }

    //MARK: - Body
    var body: some View {
        NavigationView {
            GeometryReader { proxy in
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 20) {
                        ForEach(viewModel.models, id: \.id) { model in
                            NavigationLink {
                                StationDetailView(model: model)
                            } label: {
                                CardView(model: model)
                                    .id(model.id)
                                    .padding(.horizontal, 16).padding(.top, 10).padding(.bottom, 20)
                                    .background(
                                        RoundedRectangle(cornerRadius: 12)
                                            .fill(Color.white)
                                            .shadow(color: .gray.opacity(0.2), radius: 5, x: 1, y: 2)
                                    )
                            }
                        }
                    }
                    .padding([.horizontal, .top], 16)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear {
            viewModel.getList()
        }
        .overlay(
            Color.black
                .frame(height: (UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0))
                .ignoresSafeArea(.all, edges: .top), alignment: .top)
        .onDisappear {
            viewModel.invalidate()
        }
    }
}

struct StationsListView_Previews: PreviewProvider {
    static var previews: some View {
        StationsListView()
    }
}
