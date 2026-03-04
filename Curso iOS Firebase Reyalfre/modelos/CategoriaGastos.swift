//
//  CategoriaGastos.swift
//  Curso iOS Firebase Reyalfre
//
//  Created by Equipo 8 on 4/3/26.
//

import SwiftUI

enum CategoriaGastos: String, CaseIterable, Codable {
    case comida = "Comida"
    case transporte = "Transporte"
    case ocio = "Ocio"
    case casa = "Casa"
    case sinCategoria = "Sin categoría"

    var nombreIcono: String {
        switch self {
        case .comida:
            return "fork.knife"
        case .transporte:
            return "car.fill"
        case .ocio:
            return "gamecontroller.fill"
        case .casa:
            return "house.fill"
        case .sinCategoria:
            return "questionmark.circle"
        }
    }
    var color: Color {
        switch self {
        case .comida: return .orange
        case .transporte: return .blue
        case .ocio: return .green
        case .casa: return .yellow
        case .sinCategoria: return .gray
        }
    }
}
