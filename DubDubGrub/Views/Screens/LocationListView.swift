//
//  LocationListView.swift
//  DubDubGrub
//
//  Created by Дмитро Сокотнюк on 15.07.2025.
//

import SwiftUI

struct LocationListView: View {
    var body: some View {
        NavigationStack {
            List {
                ForEach(0..<10) { item in
                    NavigationLink(destination: LocationDetailView()) {
                        LocationCell()
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("Grub Spots")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}


#Preview {
    LocationListView()
}


