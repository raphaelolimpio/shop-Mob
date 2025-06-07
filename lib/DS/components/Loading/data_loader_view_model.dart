// lib/desygn_system/components/loading/data_loader_view_model.dart

import 'package:flutter/material.dart';
import 'package:loja/DS/components/Loading/loading_enums.dart';

typedef DataLoaderFutureBuilder<T> = Future<T> Function();
typedef DataLoaderEmptyBuilder = Widget Function();
typedef DataLoaderErrorBuilder =
    Widget Function(String errorMessage, VoidCallback onRetry);
typedef DataLoaderLoadingBuilder =
    Widget Function(ProgressIndicatorType type, Color color);
typedef DataLoaderSuccessBuilder<T> = Widget Function(T data);

class DataLoaderViewModel<T> {
  /// A função assíncrona que carrega os dados.
  final DataLoaderFutureBuilder<T> futureBuilder;

  /// Construtor de widget para o estado de sucesso.
  final DataLoaderSuccessBuilder<T> successBuilder;

  /// Construtor de widget para o estado de erro. Recebe a mensagem de erro e uma função de re-tentativa.
  final DataLoaderErrorBuilder errorBuilder;

  /// Construtor de widget para o estado de dados vazios.
  final DataLoaderEmptyBuilder emptyBuilder;

  /// Construtor de widget para o estado de carregamento. Recebe o tipo de indicador e a cor.
  final DataLoaderLoadingBuilder loadingBuilder;

  /// Tempo simulado de carregamento em milissegundos (para testes).
  final int simulatedLoadingDurationMs;

  /// Número máximo de tentativas de re-carregamento.
  final int maxRetries;

  /// Callback chamado quando as tentativas se esgotam.
  final VoidCallback? onMaxRetriesReached;

  /// Mensagem de erro padrão para exibição.
  final String genericErrorMessage;

  /// Mensagem para quando não há dados.
  final String emptyDataMessage;

  /// Texto do botão de re-tentativa.
  final String retryButtonText;

  /// Cor principal do indicador de progresso.
  final Color progressIndicatorColor;

  /// Tipo de indicador de progresso visual.
  final ProgressIndicatorType progressIndicatorType;

  DataLoaderViewModel({
    required this.futureBuilder,
    required this.successBuilder,
    this.errorBuilder = _defaultErrorBuilder,
    this.emptyBuilder = _defaultEmptyBuilder,
    this.loadingBuilder = _defaultLoadingBuilder,
    this.simulatedLoadingDurationMs = 1500, // Padrão de 1.5 segundos
    this.maxRetries = 3, // Padrão de 3 tentativas
    this.onMaxRetriesReached,
    this.genericErrorMessage =
        'Ocorreu um erro ao carregar os dados. Tente novamente.',
    this.emptyDataMessage = 'Nenhuma informação encontrada.',
    this.retryButtonText = 'Tentar Novamente',
    this.progressIndicatorColor = Colors.blue, // Padrão azul
    this.progressIndicatorType = ProgressIndicatorType.circular,
  });

  // Construtores padrão para os estados
  static Widget _defaultLoadingBuilder(
    ProgressIndicatorType type,
    Color color,
  ) {
    if (type == ProgressIndicatorType.customDot) {
      return Center(
        child: Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          child: const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              strokeWidth: 2,
            ),
          ),
        ),
      );
    }
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(color),
      ),
    );
  }

  static Widget _defaultErrorBuilder(
    String errorMessage,
    VoidCallback onRetry,
  ) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, color: Colors.red, size: 50),
            const SizedBox(height: 16),
            Text(
              errorMessage,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, color: Colors.red),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: onRetry,
              child: const Text('Tentar Novamente'),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _defaultEmptyBuilder() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.info_outline, color: Colors.grey, size: 50),
            SizedBox(height: 16),
            Text(
              'Nenhuma informação encontrada.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
