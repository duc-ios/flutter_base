import 'package:flutter/material.dart';

import '../widgets/adaptive_dialog_action.dart';
import 'build_context_x.dart';

class DialogAction {
  final String text;
  final void Function()? onPressed;

  DialogAction({required this.text, this.onPressed});
}

extension BuildContextDialog on BuildContext {
  bool get isShowingDialog => ModalRoute.of(this)?.isCurrent != true;

  void showError(String message) => showAlert(title: s.error, content: message);

  void showAlert({
    String? title,
    String? content,
    List<DialogAction> actions = const [],
  }) {
    if (actions.isEmpty) {
      actions = [DialogAction(text: s.ok)];
    }
    showAdaptiveDialog(
      context: this,
      builder: (BuildContext context) => AlertDialog.adaptive(
        title: title == null ? null : Text(title),
        content: content == null ? null : Text(content),
        actions: actions
            .map((action) => AdaptiveDialogAction(
                  onPressed: action.onPressed ?? () => Navigator.pop(context),
                  child: Text(action.text),
                ))
            .toList(),
      ),
    );
  }
}
