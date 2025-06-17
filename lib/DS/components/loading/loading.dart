import 'package:flutter/material.dart';
import 'package:loja/DS/components/loading/creative_loading.dart';

class Loading extends StatelessWidget {
  final String? message;
  final Color color;

  const Loading({super.key, this.message, required this.color});

  @override
  Widget build(BuildContext context) {
    return CreativeLoading(message: message, color: color);
  }
}
