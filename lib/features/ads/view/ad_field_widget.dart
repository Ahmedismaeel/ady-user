import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sixvalley_ecommerce/features/upload_ad/controller/get_add_field_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/ads/models/add_field_model.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/provider_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/widgets/colors.dart';
import 'package:nb_utils/nb_utils.dart';

class AdFieldWidget extends ConsumerWidget {
  final int id;
  const AdFieldWidget({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: ProviderHelperWidget(
          function: (list) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text(
                //   "Ad Details",
                //   style: textStyle(16).copyWith(
                //       color: UiColors.black, fontWeight: FontWeight.bold),
                // ),
                12.height,
                FieldListWidget(
                  list: list,
                ),
              ],
            );
          },
          loadingShape: FieldListWidget(
            list: [AdFieldModel(), AdFieldModel()],
          ),
          listener: ref.watch(getAddFieldListProvider(adId: id))),
    );
  }
}

class FieldListWidget extends StatelessWidget {
  final List<AdFieldModel> list;
  const FieldListWidget({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(list[index].fieldName.toString() + " :",
                style: textStyle(16).copyWith(color: UiColors.darkGrey)),
            SizedBox(
              width: 100,
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.start,
                children: [
                  for (var element in list[index].value ?? [])
                    Text(
                      element + " ,",
                      style: textStyle(16).copyWith(color: UiColors.medGrey),
                    ).paddingAll(1)
                ],
              ),
            )
          ],
        ).paddingBottom(8);
      },
    );
  }
}
