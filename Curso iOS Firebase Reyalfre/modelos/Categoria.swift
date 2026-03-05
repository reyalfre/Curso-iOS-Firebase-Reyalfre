//
//  Categoria.swift
//  Curso iOS Firebase Reyalfre
//
//  Created by Equipo 8 on 4/3/26.
//

import FirebaseFirestore
import SwiftUI

struct Categoria: Identifiable, Codable, Hashable {
    @DocumentID var id: String?
    var nombre: String
    var icono: String
    var nombreColor: String
    var idUsuario: String  // Las categorias son únicas para cada usuario, por eso las asociamos a su idUsuario
    // var idCategoria: String // Cada gasto se asocia a una categoria de la colección Categorias

    enum CodingKeys: String, CodingKey {
        case id
        case nombre = "name"
        case icono = "icon"
        case nombreColor = "color_name"
        case idUsuario
    }
}
extension Color {
    static func fromString(_ name: String) -> Color {
        switch name {
        case "red":
            return .red
        case "blue":
            return .blue
        case "green":
            return .green
        case "orange":
            return .orange
        case "purple":
            return .purple
        case "pink":
            return .pink
        case "yellow":
            return .yellow

        default: return .gray
        }
    }
}
