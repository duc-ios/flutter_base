import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../common/utils/getit_utils.dart';
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
    return BlocProvider(
      create: (context) => getIt<SupportiveCubit>(param1: widget.slug),
      child: BlocConsumer<SupportiveCubit, SupportiveState>(
          listener: (context, state) {
        state.whenOrNull(
          loaded: (html) => controller.loadHtmlString(
              '<html><head><meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1"/></head><body>$html</body></html>'),
        );
      }, builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: Text(widget.title)),
          body: state.when(
            loading: () => const LoadingWidget(),
            error: (error) => Center(child: Text(error.message)),
            loaded: (html) => WebViewWidget(controller: controller),
          ),
        );
      }),
    );
  }
}
