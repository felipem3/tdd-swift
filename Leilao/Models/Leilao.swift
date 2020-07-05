//
//  Leilao.swift
//  Leilao
//
//  Created by Ândriu Coelho on 27/04/18.
//  Copyright © 2018 Alura. All rights reserved.
//

import Foundation

class Leilao {
    
    let descricao:String
    let imagem:String?
    var lances:[Lance]?
    
    init(descricao:String, imagem:String? = nil, lances:[Lance] = []) {
        self.descricao = descricao
        self.imagem = imagem
        self.lances = lances
    }
    
    func propoe(lance:Lance) {
        guard let listaLances = lances else {return}
                
        if listaLances.count == 0 || podeDarLance(lance.usuario, listaLances: listaLances) {
            lances?.append(lance)
        }
    }
    
    private func podeDarLance(_ usuario: Usuario, listaLances: [Lance]) -> Bool{
        return ultimoLance(listaLances).usuario != usuario && quantidadeLanceUsuario(usuario) < 5
    }
    
    private func ultimoLance(_ lances:[Lance]) -> Lance {
        return lances[lances.count-1]
    }
    
    private func quantidadeLanceUsuario(_ usuario: Usuario) -> Int {
        guard let listaLances = lances else {return 0}
        var total = 0
        for lanceAtual in listaLances {
            if lanceAtual.usuario == usuario {
                total+=1
            }
        }
        
        return total
    }
}
