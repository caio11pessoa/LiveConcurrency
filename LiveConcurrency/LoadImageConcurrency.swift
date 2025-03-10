//
//  ContentView.swift
//  LiveConcurrency
//
//  Created by Caio de Almeida Pessoa on 10/03/25.
//
//
import SwiftUI

struct LoadImageConcurrency: View {
    @State private var image: Image? = nil
    @State private var isLoading = false
    @State private var titulo: String = ""
    
    var body: some View {
        VStack {
            TextField("Título", text: $titulo)
                .padding()
            if let image = image {
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
                    .cornerRadius(12)
                    .shadow(radius: 5)
            } else {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 300, height: 300)
                    .overlay(
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                            .opacity(isLoading ? 1 : 0)
                    )
                    .cornerRadius(12)
                    .shadow(radius: 5)
            }
            
            Button(action: loadImage) {
                Text("Carregar Imagem")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .shadow(radius: 5)
            }
            .padding()
        }
    }
    
    func loadImage() {
        isLoading = true
        
        // Simula atraso de 3 segundos sem bloquear a UI
        DispatchQueue.global().asyncAfter(deadline: .now() + 3) {
            let loadedImage = Image("Vaso")
            
            // Atualiza a UI na Main Thread
            DispatchQueue.main.async {
                self.image = loadedImage
                self.isLoading = false
            }
        }
    }
}

#Preview {
    LoadImageConcurrency()
}
