import SwiftUI

// Definição de um "actor" chamado ContaBancaria
// Em Swift, "actor" é um tipo especial que ajuda a gerenciar concorrência de forma segura
// Ele garante que apenas uma thread de cada vez pode acessar ou modificar seus dados, evitando condições de corrida
actor ContaBancaria: ObservableObject {
    @Published var saldo = 200  // O saldo é privado, só pode ser acessado através dos métodos
    
    // Função para realizar um saque
    // "async" indica que essa função pode ser chamada de maneira assíncrona
    func sacar(_ valor: Int) async {
        // Verifica se o saldo é suficiente para realizar o saque
        if saldo >= valor {
            sleep(3)  // Simula o atraso de 3 segundos no processo de saque (pode ser substituído por um processo real, como uma chamada de rede)
            saldo -= valor  // Deduz o valor do saldo
            print("Saque de \(valor) realizado. Saldo atual: \(saldo)")
        } else {
            print("Saldo insuficiente")  // Se o saldo não for suficiente, imprime mensagem
        }
    }
    
    // Função para retornar o saldo atual
    func getSaldo() async -> Int {
        saldo
    }
}

// Definição da View que irá exibir os botões para o saque e o saldo
struct CorridaResolvido: View {
    // Usamos um StateObject para criar e manter o estado da conta bancária
    @StateObject private var conta: ContaBancaria = .init()
    @State var saldoAtual: Int = 0
    
    var body: some View {
        VStack {
            // Exibe o saldo atual da conta utilizando a função getSaldo()
            Text("Saldo: \(saldoAtual)")
                .padding()
            
            // Botão para realizar o saque de 190
            Button("Remover 190") {
                // Ação do botão, que chama a função sacar de maneira assíncrona
                Task {
                    print("Removendo 190 do saldo")
                    await conta.sacar(190)  // Chama o método sacar na conta bancária
                    saldoAtual = await conta.getSaldo()
                }
            }
            .padding()
            
            // Botão para realizar o saque de 150
            Button("Remover 150") {
                // Ação do botão, que chama a função sacar de maneira assíncrona
                Task {
                    print("Removendo 150 do saldo")
                    await conta.sacar(150)  // Chama o método sacar na conta bancária
                    saldoAtual = await conta.getSaldo()
                }
            }
            .padding()
        }
        .padding()
        .onAppear {
            Task {
                 saldoAtual = await conta.saldo
            }
        }
    }
}

#Preview {
    CorridaResolvido()
}
