// import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sixvalley_ecommerce/data/datasource/remote/exception/api_error_handler.dart';
import 'package:lottie/lottie.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:shimmer/shimmer.dart';
// import 'package:internal_app/global/widgets/text_function.dart';
// import 'package:lottie/lottie.dart';

class ProviderHelperWidget<T> extends ConsumerWidget {
  final AsyncValue<T> listener;
  final Widget Function(T) function;
  final Widget Function(String)? errorWidget;
  final Widget? loadingShape;
  const ProviderHelperWidget(
      {required this.function,
      required this.listener,
      this.errorWidget,
      this.loadingShape,
      Key? key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return listener.when(
        data: (response) {
          return function(response);
        },
        error: (e, s) => errorWidget != null
            ? errorWidget!(ApiErrorHandler.getMessage(e))
            : Column(
                children: [
                  Text(
                    ApiErrorHandler.getMessage(e),
                    style: TextStyle(fontSize: 12),
                  ),
                  // Lottie.asset("assets/lottie/failed.json")
                ],
              ),
        loading: () => loadingShape != null
            ? Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                enabled: true,
                child: loadingShape!)
            : const Center(
                child: CircularProgressIndicator(),
              ));
  }
}

class ProviderWidget<T> extends ConsumerWidget {
  final AsyncValue<T> Function(WidgetRef) listener;
  final Widget Function(T) function;
  final Widget Function(String)? errorWidget;
  final Widget? loadingShape;
  const ProviderWidget(
      {required this.function,
      required this.listener,
      this.errorWidget,
      this.loadingShape,
      Key? key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return listener(ref).when(
        data: (response) {
          return function(response);
        },
        error: (e, s) => errorWidget != null
            ? errorWidget!(ApiErrorHandler.getMessage(e))
            : Column(
                children: [
                  Text(
                    ApiErrorHandler.getMessage(e),
                    style: TextStyle(fontSize: 12),
                  ),
                  4.height,
                  Lottie.asset('assets/lottie/failed.json'),
                ],
              ),
        loading: () => loadingShape != null
            ? Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                enabled: true,
                child: loadingShape!)
            : const Center(
                child: CircularProgressIndicator(),
              ));
  }
}

class ListenerProviderWidget extends ConsumerWidget {
  final ProviderListenable provider;
  final Function(dynamic) onSuccess;
  final Function(dynamic) onFailed;
  const ListenerProviderWidget({
    super.key,
    required this.provider,
    required this.onSuccess,
    required this.onFailed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(provider, (previous, next) {
      next.when(() => {},
          initial: () {}, loading: () {}, success: onSuccess, failed: onFailed);
    });
    return const SizedBox.shrink();
  }
}

class SubmitWidget extends StatelessWidget {
  final ProviderListenable provider;
  final Function(dynamic) onSuccess;
  final Function(dynamic) onFailed;
  final Function(WidgetRef ref)? onTap;
  final Widget child;
  const SubmitWidget(
      {super.key,
      required this.provider,
      required this.child,
      required this.onSuccess,
      required this.onFailed,
      this.onTap});
  t() {}
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, w) {
      ref.listen(provider, (previous, next) {
        next.when(() => {},
            initial: () {},
            loading: () {},
            success: onSuccess,
            failed: onFailed);
      });

      return IgnorePointer(
        ignoring: onTap == null,
        child: InkWell(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
              onTap != null ? onTap!(ref) : print("");
            },
            child: child),
      );
    });
  }
}

extension SubmitHelper on Widget {
  Widget submit(
          {dynamic Function(WidgetRef)? onTap,
          required ProviderListenable<dynamic> provider,
          required dynamic Function(dynamic) onSuccess,
          required dynamic Function(dynamic) onFailed}) =>
      SubmitWidget(
        provider: provider,
        onSuccess: onSuccess,
        onFailed: onFailed,
        onTap: onTap,
        child: this,
      );
}
