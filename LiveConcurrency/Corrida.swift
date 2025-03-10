//
//  corrida.swift
//  LiveConcorrency
//
//  Created by Caio de Almeida Pessoa on 10/03/25.
//

import SwiftUI

class ContaBancariaCorrida: ObservableObject {
    @Published private var saldo: Int = 200

    func sacar(_ valor: Int) {
        if saldo >= valor {
            DispatchQueue.global().asyncAfter(deadline: .now() + 3) {
                DispatchQueue.main.async {
                    self.saldo -= valor
                }
            }
        } else {
            print("Saldo insuficiente")
        }
    }
    func getSaldo() -> Int {
        return saldo
    }
}

struct Corrida: View {
    @StateObject var conta: ContaBancariaCorrida = .init()
    var body: some View {
        VStack{
            Text("saldo:\(conta.getSaldo())")
            Button("remover 190") {
                conta.sacar(190)
                
            }
            Button("remover 150"){
                conta.sacar(150)
            }
        }
    }
}
#Preview {
    Corrida()
}
