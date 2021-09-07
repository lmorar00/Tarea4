//
//  ContentView.swift
//  CalculadoraSwiftUI
//
//  Created by Luis Mora Rivas on 4/9/21.
//

import SwiftUI

struct ContentView: View {
    // State variables
    @State private var primerNumero = ""
    @State private var segundoNumero = ""
    @State private var operador = ""
    @State private var calculadoraTexto = ""
    
    // Titulo de lo botones
    let buttons = [
        ["AC" , "+/-" , "%", "÷"],
        ["7" , "8" , "9", "x"],
        ["4" , "5" , "6", "-"],
        ["1" , "2" , "3", "+"],
        ["0" , "00" , ".", "="]
    ]
    
    var body: some View {
        VStack { // 1.
            VStack { // 2.
                // This text display the result and user entered
                Text(self.calculadoraTexto)
                    .font(Font.custom("HelveticaNeue-Thin", size: 78))
                    .frame(idealWidth: 100, maxWidth: .infinity, idealHeight: 100, maxHeight: .infinity, alignment: .center)
                    .foregroundColor(.white)
                
            } // 2.
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
            .background(Color.purple)
        VStack { // 3.
            Spacer(minLength: 48)
            VStack { // 4.
                ForEach(buttons, id: \.self) {
                    button in
                    HStack(alignment: .top, spacing: 0) {
                        Spacer(minLength: 13)
                        ForEach(button, id: \.self) { btn in
                            buildButton(btn)
                                .background(Color(UIColor.darkGray))
                                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
                        }
                        
                    }
                }
            } // 4.
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, idealHeight: 414, maxHeight: .infinity, alignment: .topLeading)
            .background(Color.black)
         } // 3.
        } // 1.
        .background(Color.black)
        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
    
    
    // Crea los botones de la calculadora y el asigna la accion
    private func buildButton(_ number: String) -> some View{
        return AnyView(Button(
            action: {
                if (checkIfOperator(operador: number)) {
                    self.CalculadoraOperadorAction(number)
                } else {
                    self.CalculadoraButtonAction(number)
                }
        },
            label: {
                Text(number)
                    .font(.system(size: 24))
                    .frame(idealWidth:100, maxWidth: .infinity, idealHeight: 100, maxHeight: .infinity, alignment: .center)
                    .foregroundColor(.white)
        })
       )
    }
    
    
    // Ejecuta la accion del button
    private func CalculadoraButtonAction(_ digito: String) -> Void   {
        self.calculadoraTexto = self.calculadoraTexto + digito
    }
    
    
    // Ejecuta la accion de los botones de los operadores
    private func CalculadoraOperadorAction(_ digito: String) -> Void {
        switch digito {
        case "AC":
            self.limpiar()
        case "+/-":
            self.signo()
        case "%":
            self.porcetaje()
        case "=":
            calcular()
        default:
            self.operacion(operador: digito)
        }
    }
    
    // Calcula el resultado de la operacion seleccionada
    private func calcular() -> Void {
        self.segundoNumero = self.calculadoraTexto
        
        // Primer numero
        let valor1 = (Double(primerNumero)!)
        // Segundo numero
        let valor2 = (Double(segundoNumero)!)
        
        // Resultado de la operacion
        var resultado: Double = 0.0
        
        //Evalua la operacion seleccionada
        switch operador {
        case "+":
            resultado = valor1 + valor2
        case "-":
            resultado = valor1 - valor2
        case "x":
            resultado = valor1 * valor2
        case "÷":
            resultado = valor1 / valor2
        default:
            break
        }
        
        // Asigna el resultado al campo de texto
        if (valor2 != 0) {
            if (resultado.truncatingRemainder(dividingBy: 1) == 0) {
                self.calculadoraTexto = (String(format: "%.0f", resultado))
            } else {
                self.calculadoraTexto = (String(resultado))
            }
        } else {
            self.calculadoraTexto = "Error"
        }
        
    }
    
    
    // Verifica que si el botton presionado es un operador
    private func checkIfOperator(operador: String) -> Bool {
        if operador == "÷" || operador == "x" || operador == "-"
            || operador == "+" || operador == "=" || operador == "AC" || operador == "+/-"  || operador == "%"{
            return true
        }
        return false
    }
    
    // Define la operacion a realizar
    private func operacion(operador: String) -> Void {
        self.primerNumero = self.calculadoraTexto
        self.operador = operador
        self.calculadoraTexto = ""
    }
    
    // Funcion Limpiar "AC"
    private func limpiar() -> Void {
        self.primerNumero = ""
        self.segundoNumero = ""
        self.calculadoraTexto = ""
        self.operador = ""
    }
    
    // Operador "+/-"
    private func signo() -> Void {
        if self.calculadoraTexto.contains("-") {
            self.calculadoraTexto = self.calculadoraTexto.replacingOccurrences(of: "-", with: "")
        } else {
            self.calculadoraTexto = "-" + self.calculadoraTexto
        }
    }
    
    // Operacion de %
    private func porcetaje() -> Void {
        // Primer numero
        var valor1: Double = 0.0
        // Segundo numero
        var valor2: Double = 0.0
        // Resultado de la operacion
        var resultado: Double = 0.0
        
        if (primerNumero == "" && segundoNumero == "") {
            valor1 = (Double(calculadoraTexto)) ?? 0
            if valor1 == 0 {
                calculadoraTexto = "0"
            } else {
                resultado = valor1 / 100
            }
        } else if (primerNumero != ""){
            segundoNumero = calculadoraTexto
            valor1 = (Double(primerNumero)!)
            valor2 = (Double(segundoNumero)!)
            resultado = (valor1 * valor2) / 100
        }
        
        if (resultado.truncatingRemainder(dividingBy: 1) == 0) {
            calculadoraTexto = (String(format: "%.0f", resultado))
        } else {
            calculadoraTexto = (String(resultado))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
