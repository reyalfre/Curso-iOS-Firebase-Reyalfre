//
//  VistaAnadirGasto.swift
//  Curso iOS Firebase Reyalfre
//
//  Created by Equipo 8 on 2/3/26.
//

import SwiftUI

struct VistaAnadirGasto: View {
    @Environment(\.dismiss) private var dismiss
    var viewModel: GastosViewModel
    @State private var titulo = ""
    @State private var importe: Double = 0.0
    @State private var idCategoriaSeleccionada: String = ""

    @State private var mostrarCategorias: Bool = false
    var body: some View {
        NavigationStack {
            Form {
                TextField("Concepto (ej. Comprar en el día)", text: $titulo)

                TextField("Importe", value: $importe, format: .number)
                    .keyboardType(.decimalPad)

                Picker("Categoria", selection: $idCategoriaSeleccionada) {
                    if viewModel.categorias.isEmpty {
                        Text("No hay categorías disponibles")
                            .tag("")
                    }
                    ForEach(viewModel.categorias) {
                        categoria in
                        HStack {
                            Image(systemName: categoria.icono)
                            Text(categoria.nombre)
                        }
                        .tag(categoria.id ?? "")
                    }
                }
                .onAppear {
                    if let primera = viewModel.categorias.first,
                        idCategoriaSeleccionada.isEmpty
                    {
                        idCategoriaSeleccionada = primera.id ?? ""
                    }
                }
            }
            .navigationTitle("Nuevo gasto")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("cancelar") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Guardar") {
                        viewModel.anadirGasto(
                            titulo: titulo,
                            importe: importe,
                            idCategoria: idCategoriaSeleccionada
                        )
                        dismiss()
                    }
                    .disabled(titulo.isEmpty || importe == 0)
                }
                ToolbarItem(placement: .bottomBar){
                    Button("Categorias"){
                        mostrarCategorias = true
                    }
                    .buttonStyle(.borderless)
                    .tint(.orange)
                }
            }
            .sheet(isPresented: $mostrarCategorias){
                VistaNuevaCategoria(viewModel: viewModel)
            }
        }
    }
}
/*
#Preview {
    VistaAnadirGasto(viewModel: GastosViewModelMock(idUsuario: "apsdfiu3204"))
}
*/
