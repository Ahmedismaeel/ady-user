import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sixvalley_ecommerce/features/update_ad/controller/get_edit_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/upload_ad/view/edit_ad_view.dart';
import 'package:flutter_sixvalley_ecommerce/utill/api_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/provider_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/translate_helper.dart';

class UpdateAdView extends ConsumerStatefulWidget {
  final int adId;
  const UpdateAdView({
    super.key,
    required this.adId,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UpdateAdViewState();
}

class _UpdateAdViewState extends ConsumerState<UpdateAdView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Ad".translate(context)),
      ),
      body: ProviderHelperWidget(
        function: (helper) {
          "${helper.toJson()}".log();
          return Container(
            child:
                // Text("${helper.toJson()}")
                EditAdView(
              editHelper: helper,
            ),
          );
        },
        listener: ref.watch(getEditProvider(widget.adId)),
      ),
    );
  }
}
