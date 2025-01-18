import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sixvalley_ecommerce/data/datasource/remote/dio/share_preferance.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/utill/api_helper.dart';
import 'package:nb_utils/nb_utils.dart';

extension TranslateHelper on String {
  String translate(BuildContext context) {
    // homeRef.read(fileManagerProvider.notifier).write(this);
    return getTranslated(this, context);
  }

  Color fromHex() {
    final buffer = StringBuffer();
    if (length == 6 || length == 7) buffer.write('ff');
    buffer.write(replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}

// extension TranslateExtension on Text {
//   tr() => TranslateHelperWidget(text: this);
// }

class TranslateHelperWidget extends StatefulWidget {
  final Text text;
  const TranslateHelperWidget({super.key, required this.text});

  @override
  State<TranslateHelperWidget> createState() => _TranslateHelperWidgetState();
}

class _TranslateHelperWidgetState extends State<TranslateHelperWidget> {
  @override
  void initState() {
    afterBuildCreated(() async {
      String value = widget.text.data ?? "";
      Map<String, dynamic>? data = SharedPreferenceHelper.instance.getLang();
      if (data != null) {
        Map<String, dynamic> map = {};
        map.addAll(data);
        map.putIfAbsent("$value", () => "$value");
        await SharedPreferenceHelper.instance.saveLang(map);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.text;
  }
}

class FileManagerNotifier extends StateNotifier<Map<String, String>> {
  FileManagerNotifier() : super({});

  write(String value) async {
    Map<String, dynamic>? data = SharedPreferenceHelper.instance.getLang();
    "$data".log();
    if (data != null) {
      Map<String, dynamic> map = {};
      map.addAll(data);
      map.putIfAbsent("$value", () => "$value");

      await SharedPreferenceHelper.instance.saveLang(map);
    }
  }
}

final fileManagerProvider =
    StateNotifierProvider<FileManagerNotifier, Map<String, String>>((ref) {
  return FileManagerNotifier();
});
