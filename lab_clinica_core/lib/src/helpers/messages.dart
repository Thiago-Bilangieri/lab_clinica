import 'package:flutter/material.dart';
import 'package:signals_flutter/signals_flutter.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

final class Messages {
  static void showError(String message, BuildContext buildContext) {
    showTopSnackBar(
      Overlay.of(buildContext),
      CustomSnackBar.error(message: message),
    );
  }

  static void showInfo(String message, BuildContext buildContext) {
    showTopSnackBar(
      Overlay.of(buildContext),
      CustomSnackBar.info(message: message),
    );
  }

  static void showSuccess(String message, BuildContext buildContext) {
    showTopSnackBar(
      Overlay.of(buildContext),
      CustomSnackBar.success(message: message),
    );
  }
}

mixin MessageStateMixin {
  final Signal<String?> _errorMessage = signal(null);
  String? get errorMessage => _errorMessage();
  final Signal<String?> _infoMessage = signal(null);
  String? get infoMessage => _infoMessage();
  final Signal<String?> _successMessage = signal(null);
  String? get successMessage => _successMessage();

  void clearError() => _errorMessage.value = null;
  void clearInfo() => _infoMessage.value = null;
  void clearSuccess() => _successMessage.value = null;

  void showInfo(String message) {
    untracked(() => clearInfo());
    _infoMessage.value = message;
  }

  void showSuccess(String message) {
    untracked(() => clearSuccess());
    _successMessage.value = message;
  }

  void showError(String message) {
    untracked(() => clearError());
    _errorMessage.value = message;
  }

  void clearAllMessage() {
    untracked(() {
      clearError();
      clearInfo();
      clearSuccess();
    });
  }
}

mixin MessagesViewMixin<T extends StatefulWidget> on State<T> {
  void messageListener(MessageStateMixin messageStateMixin) {
    effect(() {
      switch (messageStateMixin) {
        case MessageStateMixin(:final errorMessage?):
          Messages.showError(errorMessage, context);
        case MessageStateMixin(:final infoMessage?):
          Messages.showError(infoMessage, context);
        case MessageStateMixin(:final successMessage?):
          Messages.showError(successMessage, context);
      }
    });
  }
}
