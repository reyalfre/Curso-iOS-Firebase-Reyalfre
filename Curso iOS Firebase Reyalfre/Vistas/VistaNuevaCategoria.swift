//
//  VistaNuevaCategoria.swift
//  Curso iOS Firebase Reyalfre
//
//  Created by Equipo 8 on 5/3/26.
//

import SwiftUI

struct VistaNuevaCategoria: View {
    @Environment(\.dismiss) var dismiss
    var viewModel: GastosViewModel

    @State private var nombre = ""
    @State private var iconoSeleccionado = "house.fill"
    @State private var colorSeleccionado = "blue"

    let iconos = ["house.fill", "car.fill", "cart.fill", "heart.fill"]
    let colores = [
        "red", "blue", "green", "orange", "purple", "pink", "yellow",
    ]
    var body: some View {
        Form {
            TextField("Nombre", text: $nombre)

            Picker("Icono", selection: $iconoSeleccionado) {
                ForEach(iconos, id: \.self) {
                    icon in
                    Image(systemName: icon)
                        .tag(icon)
                }
            }
            .pickerStyle(.segmented)

            Picker("Color", selection: $colorSeleccionado) {
                ForEach(colores, id: \.self) {
                    color in
                    Text(color.capitalized)
                        .foregroundStyle(Color(color))
                        .tag(color)
                }
            }
            .pickerStyle(.segmented)
            
            Button("Crear categoria"){
                viewModel.anadirCategoria(nombre: nombre, icono: iconoSeleccionado, color: colorSeleccionado)
                dismiss()
            }
            .disabled(nombre.isEmpty)
        }
    }
}
/*
#Preview {
    VistaNuevaCategoria()
}
*/
