//
//  Assembler.swift
//  AccountKeeper
//
//  Created by NamTrinh on 16/06/2023.
//

protocol Assembler: AnyObject,
                    AppAssembler,
                    MainAssembler,
                    PasscodeAssembler ,
                    AddAccountAssembler {
}

final class DefaultAssembler: Assembler {}

