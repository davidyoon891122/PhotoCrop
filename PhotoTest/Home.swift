//
//  Home.swift
//  PhotoTest
//
//  Created by Jiwon Yoon on 4/1/25.
//

import SwiftUI

struct Home: View {
    @State private var showPicker: Bool = false
    @State private var croppedImage: UIImage?

    var body: some View {
        NavigationStack {
            VStack {
                if let croppedImage = croppedImage {
                    Image(uiImage: croppedImage)
                        
                } else {
                    Text("No Image is Selected")
                        .font(.caption)
                        .foregroundStyle(.gray)
                }
            }
            .navigationTitle("Crop Image Picker")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        showPicker.toggle()
                    }, label: {
                        Image(systemName: "photo.on.rectangle.angled")
                            .font(.callout)
                    })
                }
            }
            .cropImagePicker(options: [.circle, .square, .rectangle],
                             show: $showPicker,
                             croppedImage: $croppedImage)
        }
    }
}

#Preview {
    Home()
}
