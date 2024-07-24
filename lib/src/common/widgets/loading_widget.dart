import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
    this.child,
    this.isLoading = true,
    this.color,
  });

  final Widget? child;
  final bool isLoading;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (child != null) child!,
        if (isLoading)
          Container(
            alignment: Alignment.center,
            width: double.infinity,
            height: double.infinity,
            color: color,
            child: const CircularProgressIndicator(),
          )
      ],
    );
  }
}
