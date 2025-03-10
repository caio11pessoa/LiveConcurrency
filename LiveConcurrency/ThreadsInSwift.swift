//
//  ThreadsInSwift.swift
//  LiveConcorrency
//
//  Created by Caio de Almeida Pessoa on 10/03/25.
//
import SwiftUI

struct ThreadsInSwift: View {
    @State private var imageOne: Image? = nil
    @State private var imageTwo: Image? = nil
    @State private var imageThree: Image? = nil
    @State private var imageFour: Image? = nil

    var body: some View {
        VStack {
            // Primeira imagem - Thread
            if let imageOne {
                imageOne
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .cornerRadius(12)
                    .shadow(radius: 5)
            } else {
                Button {
                    Thread {
                        sleep(5) // Simula carregamento
                        DispatchQueue.main.async {
                            self.imageOne = Image(systemName: "moon.stars.fill")
                        }
                    }.start()
                } label: {
                    Text("Download ImageOne")
                }
            }

            // Segunda imagem - Thread
            if let imageTwo {
                imageTwo
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .cornerRadius(12)
                    .shadow(radius: 5)
            } else {
                Button {
                    Thread {
                        sleep(5) // Simula carregamento
                        DispatchQueue.main.async {
                            self.imageTwo = Image(systemName: "sun.max.fill")
                        }
                    }.start()
                } label: {
                    Text("Download ImageTwo")
                }
            }

            // Terceira imagem - DispatchQueue
            if let imageThree {
                imageThree
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .cornerRadius(12)
                    .shadow(radius: 5)
            } else {
                Button {
                    DispatchQueue.global().asyncAfter(deadline: .now() + 5) {
                        let loadedImage = Image(systemName: "cloud.fill")
                        DispatchQueue.main.async {
                            self.imageThree = loadedImage
                        }
                    }
                } label: {
                    Text("Download ImageThree")
                }
            }

            // Quarta imagem - DispatchQueue
            if let imageFour {
                imageFour
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .cornerRadius(12)
                    .shadow(radius: 5)
            } else {
                Button {
                    DispatchQueue.global().asyncAfter(deadline: .now() + 5) {
                        let loadedImage = Image(systemName: "star.fill")
                        DispatchQueue.main.async {
                            self.imageFour = loadedImage
                        }
                    }
                } label: {
                    Text("Download ImageFour")
                }
            }
        }
        .padding()
    }
}

#Preview {
    ThreadsInSwift()
}
