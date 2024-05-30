//
//  Results.swift
//  iExpense
//
//  Created by Leandro Morais on 29.05.2024.
//

import SwiftUI

        // Models
        struct Avaliação: Identifiable, Codable {
            var id = UUID()
            let funcionalidade: String // "Manutenção de Receitas", "Manutenção de Despesas", "Fluxo de Caixa"
            let nota: Int
            let comentário: String?
        }

        // ViewModels
        class AvaliaçãoViewModel: ObservableObject {
            @Published var nota: Int = 0
            @Published var comentário: String? = nil
            @Published var avaliações: [Avaliação] = []
            
            var bindingComentário: Binding<String?> { // Note the optional type for String?
                Binding<String?>(
                  get: { self.comentário },
                  set: { self.comentário = $0 }
                )
              }

            func salvarAvaliação(funcionalidade: String, nota: Int, comentário: String?) {
                // Salvar avaliação no armazenamento local
            }

            func enviarAvaliação() {
                // Enviar avaliações para o desenvolvedor (implementar lógica)
            }
        }

        // Views
        struct AvaliaçãoView: View {
            @StateObject var viewModel = AvaliaçãoViewModel()
            let funcionalidade: String

            var body: some View {
                Form {
                    Section("Avaliação") {
                        Picker("Nota", selection: $viewModel.nota) {
                            ForEach(1..<6) { numero in
                                Text("\(numero)")
                                    .tag(numero)
                            }
                        }.pickerStyle(.segmented)
                    }

// NÃO USAR COMENTÁRIOS.
//                    Section("Comentários") {
//                        TextField("Comentários (opcional)", text: $viewModel.bindingComentário)
//                          }

                    Button("Salvar") {
                        viewModel.salvarAvaliação(funcionalidade: funcionalidade, nota: viewModel.nota, comentário: viewModel.comentário)
                    }
                }
            }
        }



        struct ConteúdoView: View {
            @StateObject var viewModel = AvaliaçãoViewModel()

            var body: some View {
                NavigationView {
                    List {
                        NavigationLink(destination: AvaliaçãoView(funcionalidade: "Manutenção de Receitas")) {
                            Text("Manutenção de Receitas")
                        }

                        NavigationLink(destination: AvaliaçãoView(funcionalidade: "Manutenção de Despesas")) {
                            Text("Manutenção de Despesas")
                        }

                        NavigationLink(destination: AvaliaçãoView(funcionalidade: "Fluxo de Caixa")) {
                            Text("Fluxo de Caixa")
                        }

                        Button("Enviar Avaliações") {
                            viewModel.enviarAvaliação()
                        }
                    }
                    .navigationTitle("Avaliação do Software")
                }
            }
        }



#Preview {
    ConteúdoView()
}
