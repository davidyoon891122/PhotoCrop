//
//  SwiftyCropViewHome.swift
//  PhotoTest
//
//  Created by Jiwon Yoon on 4/1/25.
//

import SwiftUI
import PhotosUI
import SwiftyCrop

struct SwiftyCropViewHome: View {

    @State var selectedItems: [PhotosPickerItem] = []
    @State var displayedImage: UIImage?
    @State private var showImageCropper: Bool = false
    @State var croppedImage: UIImage?

    var body: some View {
        VStack {
            PhotosPicker(selection: $selectedItems, maxSelectionCount: 1, matching: .images) {
                Text("Select Multiple Photos")
            }

            if let displayedImage = displayedImage {
                Image(uiImage: displayedImage)
                    .resizable()
                    .frame(maxWidth: .infinity, maxHeight: 300.0)
            }

            if let croppedImage = croppedImage {
                Image(uiImage: croppedImage)
                    .resizable()
                    .frame(maxWidth: .infinity, maxHeight: 300.0)
                    .clipShape(.circle)
            }

            Button("Crop downloaded image") {
                showImageCropper.toggle()
            }

        }
        .onChange(of: selectedItems) { item in
            loadTransferable(from: item)
        }
        .fullScreenCover(isPresented: $showImageCropper) {
            if let displayedImage = displayedImage {

                let configuration = SwiftyCropConfiguration(colors: SwiftyCropConfiguration.Colors(cancelButton: .red, interactionInstructions: .blue, saveButton: .cyan, background: .gray))

                SwiftyCropView(imageToCrop: displayedImage,
                               maskShape: .circle,
                               configuration: configuration) { croppedImage in
                    self.croppedImage = croppedImage
                }
            }
        }
    }

    func loadTransferable(from imageSelection: [PhotosPickerItem]) {
        guard let targetItem = imageSelection.first else {
            return
        }

        targetItem.loadTransferable(type: Data.self) { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    guard let data = data else { return }
                    self.displayedImage = UIImage(data: data)
                }
            case .failure(let error):
                print("Error loading image: \(error)")
            }
        }
    }
}

#Preview {
    SwiftyCropViewHome()
}
