// lib/desygn_system/components/input/input_text/input_text_view_model.dart

import 'package:flutter/material.dart';

enum InputTextSize { small, medium, large }

// O InputTextType pode ser simplificado ou expandido.
// Por enquanto, vamos manter e garantir que o keyboardType seja o principal.
enum InputTextType {
  string,
  phone,
  email,
  password,
} // Adicionei mais tipos para validação

class InputTextViewModel {
  final InputTextSize size;
  final String hintText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final bool isEnabled;
  final InputTextType inputType; // Usaremos isso para lógica de validação
  final Function(String)? onChanged; // Novo: Callback para quando o texto muda
  final String? errorText; // Novo: Mensagem de erro para exibição
  final Widget? suffixIcon; // Novo: Ícone à direita, para senhas, etc.
  final Widget? prefixIcon; // Novo: Ícone à esquerda, para personalização

  InputTextViewModel({
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.isEnabled = true,
    required this.size,
    required this.hintText,
    required this.controller,
    this.inputType = InputTextType.string,
    this.onChanged, // Inicialize o novo parâmetro
    this.errorText, // Inicialize o novo parâmetro
    this.suffixIcon, // Inicialize o novo parâmetro
    this.prefixIcon, // Inicialize o novo parâmetro
  });
}
