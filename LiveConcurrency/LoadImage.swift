import SwiftUI

struct LoadImage: View {
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
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .shadow(radius: 5)
            }
            .padding()
        }
    }
    
    func loadImage() {
        isLoading = true
        sleep(5) // Simula um atraso de 5 segundos (trava a UI!)
        image = Image("Vaso")
        
        isLoading = false
    }
}

#Preview{
    LoadImage()
}
