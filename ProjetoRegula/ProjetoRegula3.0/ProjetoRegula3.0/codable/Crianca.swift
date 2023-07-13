//
//  Crianca.swift
//  ProjetoRegula3.0
//
//  Created by projeto on 30/05/2023.
//

import Foundation
public struct Criancas: Codable{
    var comentario: String
    var created_at: Int
    var dataNascimento: DataNascimento
    var dataUltimaAvaliacao: String
    var id: Int
    var genero: String
    var idSession: String
    var idTerapeuta: String
    var nome: String
    var parentName: String
    var status: String
    var storageImageRef:String
    var tipoAutismo: String
    var estrategiasFavoritas: [Estrategia]
    var estrategiasRecomendadas: [Estrategia]
    
    enum CodingKeys: String, CodingKey {
        case comentario
        case created_at
        case dataNascimento
        case dataUltimaAvaliacao
        case id
        case genero
        case idSession
        case idTerapeuta
        case nome
        case parentName
        case status
        case storageImageRef
        case tipoAutismo
        case estrategiasFavoritas
        case estrategiasRecomendadas
        }


    r
}
