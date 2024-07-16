import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../common/widgets/loading_widget.dart';
import '../../application/supportive_cubit/supportive_cubit.dart';

@RoutePage()
class SupportivePage extends StatefulWidget {
  const SupportivePage({
    super.key,
    required this.title,
    required this.slug,
  });

  final String slug;
  final String title;

  @override
  State<SupportivePage> createState() => _SupportivePageState();
}

class _SupportivePageState extends State<SupportivePage> {
  final controller = WebViewController()
    ..setBackgroundColor(Colors.transparent);

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (_, ref, __) {
      ref.listen(
        supportiveProvider(widget.slug),
        (_, current) => current.whenOrNull(
          loaded: (html) => controller.loadHtmlString(
              '<html><head><meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1"/></head><body>$html</body></html>'),
        ),
      );
      return Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body: ref.watch(supportiveProvider(widget.slug)).when(
              loading: () => const LoadingWidget(),
              error: (error) => Center(child: Text(error.message)),
              loaded: (html) => WebViewWidget(controller: controller),
            ),
      );
    });
  }
}
