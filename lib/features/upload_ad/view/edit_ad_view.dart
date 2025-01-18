import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_button_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/show_custom_snakbar_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/ads/controller/governorate_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/ads/controller/wilaya_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/update_ad/controller/edit_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/update_ad/model/edit_response.dart';
import 'package:flutter_sixvalley_ecommerce/features/upload_ad/controller/category_field_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/upload_ad/controller/upload_image_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/upload_ad/controller/create_ad_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/upload_ad/helper/governorate_helper.dart';
import 'package:flutter_sixvalley_ecommerce/features/upload_ad/helper/phone_option_helper.dart';
import 'package:flutter_sixvalley_ecommerce/features/upload_ad/helper/select_field_helper.dart';
import 'package:flutter_sixvalley_ecommerce/features/upload_ad/helper/wilaya_helper.dart';
import 'package:flutter_sixvalley_ecommerce/features/upload_ad/model/save_data_model.dart';
import 'package:flutter_sixvalley_ecommerce/features/upload_ad/view/field_selection_view.dart';
import 'package:flutter_sixvalley_ecommerce/features/upload_ad/view/map_selection_view.dart';
import 'package:flutter_sixvalley_ecommerce/features/upload_ad/view/select_governorate_view.dart';
import 'package:flutter_sixvalley_ecommerce/features/upload_ad/view/select_wilayat_view.dart';
import 'package:flutter_sixvalley_ecommerce/helper/cach_image.dart';
import 'package:flutter_sixvalley_ecommerce/helper/velidate_check.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/theme/controllers/theme_controller.dart';
import 'package:flutter_sixvalley_ecommerce/utill/api_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/provider_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/translate_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/widgets/colors.dart';
import 'package:flutter_sixvalley_ecommerce/utill/widgets/edit_text.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';
import 'package:nb_utils/nb_utils.dart';

class EditAdView extends ConsumerStatefulWidget {
  final EditResponse editHelper;
  const EditAdView({super.key, required this.editHelper});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditAdViewState();
}

class _EditAdViewState extends ConsumerState<EditAdView> {
  @override
  void initState() {
    super.initState();

    afterBuildCreated(() {
      try {
        nameAr = TextEditingController(
            text: widget.editHelper.translations
                ?.firstWhere((item) => item.key == 'name')
                .value);
        descriptionAr = TextEditingController(
            text: widget.editHelper.translations
                ?.firstWhere((item) => item.key == 'description')
                .value);

        imageStringList.addAll(List.generate(
                jsonDecode("${widget.editHelper.images}")?.length ?? 0,
                (index) => jsonDecode("${widget.editHelper.images}")?[index]
                    ["image_name"]) ??
            []);

        ref.read(governorateHelperProvider.notifier).set(ref
            .watch(governorateListProvider)
            .asData!
            .value
            .firstWhere((test) => widget.editHelper.governorateId == test.id));
        ref.read(wilayatHelperProvider.notifier).setWilayat(ref
            .watch(wilayaListProvider(widget.editHelper.governorateId ?? 0))
            .asData!
            .value
            .firstWhere((test) => widget.editHelper.wilyaId == test.id));
      } catch (e) {}
      nameEn =
          TextEditingController(text: widget.editHelper.translations?[0].value);

      phone = TextEditingController(text: widget.editHelper.phone);
      nameEn = TextEditingController(text: widget.editHelper.name);
      unitPrice =
          TextEditingController(text: "${widget.editHelper.unitPrice ?? 0.00}");
      descriptionEn = TextEditingController(text: widget.editHelper.details);

      thumbnailString = widget.editHelper.thumbnail ?? null;
      setState(() {});
    });
  }

  List<String> imageStringList = [];
  String? thumbnailString;

  TextEditingController nameAr = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController nameEn = TextEditingController();
  TextEditingController unitPrice = TextEditingController();
  TextEditingController descriptionAr = TextEditingController();
  TextEditingController descriptionEn = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();

  double? latitude;
  double? longitude;
  @override
  Widget build(BuildContext context) {
    "${widget.editHelper.images}".log();
    "${widget.editHelper.thumbnail}".log();

    ref.watch(getCategoryFieldsProvider);
    ref.listen(uploadImageProvider, (s, next) {
      next.when(() {}, initial: () {}, loading: () {}, success: (onSuccess) {
        "${onSuccess.type}".log();
        "${onSuccess.imageName}".log();
        // "${ImageType.product.name}".log();
        if (onSuccess.type == ImageType.product.name) {
          imageStringList.add(onSuccess.imageName ?? "");
        } else if (onSuccess.type == ImageType.thumbnail.name) {
          thumbnailString = onSuccess.imageName;
        }
      }, failed: (e) {
        showCustomSnackBar("$e", context);
      });
    });
    return Scaffold(
      // appBar: const CustomAppBar(title: "Upload Ad"),
      bottomNavigationBar: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: SubmitWidget(
            onTap: (ref) async {
              if (formKey.currentState?.validate() == true) {
                if (imageStringList.isEmpty) {
                  showCustomSnackBar(
                      getTranslated(
                          'Please add ad images'.translate(context), context),
                      context);
                  return;
                }
                if (thumbnailString == null) {
                  showCustomSnackBar(
                      getTranslated(
                          'Please add Image thumbnail'.translate(context),
                          context),
                      context);
                  return;
                }

                // final plan = await SelectPlanView(
                //   categoryId: ref.watch(categoryIdProvider).id ?? 0,
                // ).launch(context);

                // if (plan == null) {
                //   showCustomSnackBar("Please Select Plan First", context);
                //   return;
                // }
                // if (ref.watch(wilayatHelperProvider) == null) {
                //   showCustomSnackBar(
                //       "Please Select Wilaya First".translate(context), context);
                //   return;
                // }
                ref.read(editAdProvider.notifier).update(
                      nameAr: nameAr,
                      nameEn: nameEn,
                      unitPrice: unitPrice,
                      descriptionAr: descriptionAr,
                      descriptionEn: descriptionEn,
                      thumbnail: thumbnailString,
                      imageList: imageStringList,
                      phone: phone,
                      adId: widget.editHelper.id ?? 0,
                      governorateId: ref.watch(governorateHelperProvider)?.id ??
                          widget.editHelper.governorateId,
                      wilyaId: ref.watch(wilayatHelperProvider)?.id ??
                          widget.editHelper.wilyaId,
                      // subscribedPlanId: plan[0].id
                    );
              } else {
                return;
              }
            },
            provider: editAdProvider,
            child: IgnorePointer(
              child: CustomButton(
                buttonText: "Update".translate(context),
                backgroundColor: UiColors.darkBlue,
                textColor: UiColors.white,
                onTap: () {},
              ),
            ),
            onSuccess: (onSuccess) {
              showCustomSnackBar("Success", context, isError: false);

              Navigator.pop(context);
              Navigator.pop(context);
            },
            onFailed: (onFailed) {}),
      ),

      body: Form(
        key: formKey,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: ListView(
            children: [
              // Text("${jsonDecode("${widget.editHelper.images}")}"),
              DropDownSelection(
                title: 'Governorate'.translate(context),
                value: ref.watch(governorateHelperProvider)?.getName() ??
                    "Select Governorate".translate(context),
                onEdit: () {
                  SmartDialog.show(
                      animationType: SmartAnimationType.fade,
                      builder: (BuildContext context) {
                        return const SelectGovernorateWidget(
                          isEdit: true,
                        );
                      });
                },
              ),
              12.height,
              DropDownSelection(
                title: 'Wilayat'.translate(context),
                value: ref.watch(wilayatHelperProvider)?.getName() ??
                    "Select Wilayat".translate(context),
                onEdit: () {
                  SmartDialog.show(
                      animationType: SmartAnimationType.fade,
                      builder: (BuildContext context) {
                        return const SelectWilayatView(
                          isEdit: true,
                        );
                      });
                },
              ),
              12.height,
              for (SaveAddHelperModel element
                  in ref.watch(saveHelperProvider) ?? [])
                Container(
                  decoration: boxDecorationDefault(
                      border: Border.all(color: UiColors.borderBlue),
                      color: UiColors.bgBlue,
                      boxShadow: []),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${element.field?.field.name}",
                            style: textStyle(18),
                          ),
                        ],
                      ),
                      12.height,
                      for (String value in element.values ?? [])
                        switch (element.field?.field.type) {
                          1 => Container(
                              decoration: boxDecorationDefault(
                                  boxShadow: [],
                                  borderRadius: BorderRadius.circular(10)),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        value,
                                        style: textStyle(16)
                                            .copyWith(color: UiColors.darkBlue),
                                      ),
                                    ],
                                  ),
                                  const Icon(
                                    Icons.edit_square,
                                    color: UiColors.darkBlue,
                                  ).onTap(() {
                                    SmartDialog.show(
                                        animationType: SmartAnimationType.fade,
                                        builder: (BuildContext context) =>
                                            FieldSelectionView(
                                              isEdit: true,
                                              field: element.field!,
                                            ));
                                  })
                                ],
                              )),
                          2 => Container(
                              decoration: boxDecorationDefault(
                                  boxShadow: [],
                                  borderRadius: BorderRadius.circular(50)),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.radio_button_checked,
                                        size: 20,
                                        color: UiColors.darkBlue,
                                      ),
                                      8.width,
                                      Text(
                                        value,
                                        style: textStyle(16)
                                            .copyWith(color: UiColors.darkBlue),
                                      ),
                                    ],
                                  ),
                                  const Icon(
                                    Icons.edit_square,
                                    color: UiColors.darkBlue,
                                  ).onTap(() {
                                    SmartDialog.show(
                                        animationType: SmartAnimationType.fade,
                                        builder: (BuildContext context) =>
                                            FieldSelectionView(
                                              isEdit: true,
                                              field: element.field!,
                                            ));
                                  })
                                ],
                              )),
                          3 => Container(
                              decoration: boxDecorationDefault(
                                  boxShadow: [],
                                  borderRadius: BorderRadius.circular(5)),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.check_box,
                                        color: UiColors.darkBlue,
                                      ),
                                      8.width,
                                      Text(
                                        value,
                                        style: textStyle(16)
                                            .copyWith(color: UiColors.darkBlue),
                                      ),
                                    ],
                                  ),
                                ],
                              )).paddingBottom(8),
                          4 => Container(
                              decoration: boxDecorationDefault(
                                  boxShadow: [],
                                  borderRadius: BorderRadius.circular(10)),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        value,
                                        style: textStyle(16)
                                            .copyWith(color: UiColors.darkBlue),
                                      ),
                                    ],
                                  ),
                                  const Icon(
                                    Icons.edit_square,
                                    color: UiColors.darkBlue,
                                  ).onTap(() {
                                    SmartDialog.show(
                                        animationType: SmartAnimationType.fade,
                                        builder: (BuildContext context) =>
                                            FieldSelectionView(
                                              isEdit: true,
                                              field: element.field!,
                                            ));
                                  })
                                ],
                              )),
                          int() => Text(value),
                          null => Text(value)
                        },
                      element.field?.field.type == 3
                          ? Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 7),
                              decoration: boxDecorationDefault(
                                  boxShadow: [], color: UiColors.borderBlue),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.edit_square,
                                    color: UiColors.darkBlue,
                                  ),
                                  6.width,
                                  Text(
                                    "Edit".translate(context),
                                    style: textStyle(16)
                                        .copyWith(color: UiColors.darkBlue),
                                  ),
                                ],
                              ),
                            ).onTap(() {
                              SmartDialog.show(
                                  animationType: SmartAnimationType.fade,
                                  builder: (BuildContext context) =>
                                      FieldSelectionView(
                                        isEdit: true,
                                        field: element.field!,
                                      ));
                            }).paddingTop(8)
                          : const SizedBox.shrink()
                    ],
                  ),
                ).paddingBottom(12),
              Container(
                  decoration: boxDecorationDefault(
                      border: Border.all(color: UiColors.borderBlue),
                      color: UiColors.bgBlue,
                      boxShadow: []),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "contact_information".translate(context),
                        style: textStyle(20),
                      ),
                      24.height,
                      Text(
                        "Mobile number".translate(context),
                        style: textStyle(16),
                      ),
                      12.height,
                      TextFormField(
                          maxLength: 8,
                          validator: (value) => ValidateCheck.validateEmptyText(
                              value,
                              "Mobile Number is required".translate(context)),
                          controller: phone,
                          keyboardType: TextInputType.phone,
                          decoration: whiteEditTextDecoration().copyWith(
                              prefixIcon: Container(
                            child: const Icon(Icons.phone,
                                size: 30, color: UiColors.darkBlue),
                          ))),
                      Text(
                        "How do you like to contact".translate(context),
                        style: textStyle(16),
                      ),
                      12.height,
                      PhoneOptionsWidget()
                    ],
                  )),
              12.height,
              InputFieldWidget(
                titleText: 'Name Arabic'.translate(context),
                controller: nameAr,
                validator: (value) => ValidateCheck.validateEmptyText(
                    value, "name arabic is required".translate(context)),
              ),
              12.height,
              InputFieldWidget(
                titleText: "Name English".translate(context),
                controller: nameEn,
                validator: (value) => ValidateCheck.validateEmptyText(
                    value, "name english is required".translate(context)),
              ),
              12.height,
              InputFieldWidget(
                titleText: "Unit Price".translate(context),
                hintText: "Ex:  1.00\$",
                keyboardType: TextInputType.number,
                validator: (value) => ValidateCheck.validateEmptyText(
                    value, "unit price is required".translate(context)),
                controller: unitPrice,
              ),
              12.height,
              InputFieldWidget(
                titleText: "Description Arabic".translate(context),
                maxLines: 4,
                validator: (value) => ValidateCheck.validateEmptyText(
                    value, "description arabic is required".translate(context)),
                controller: descriptionAr,
              ),
              12.height,
              InputFieldWidget(
                titleText: "Description English".translate(context),
                maxLines: 4,
                validator: (value) => ValidateCheck.validateEmptyText(
                    value, "description arabic is required".translate(context)),
                controller: descriptionEn,
              ),
              12.height,
              SelectLocationWidget(
                key: UniqueKey(),
                location: ref.watch(locationAdProvider) ??
                    LocationAd(
                        latitude: 23.602036542892446,
                        longitude: 58.35978231654114),
              ),
              12.height,
              Container(
                  decoration: boxDecorationDefault(
                      boxShadow: [],
                      color: const Color(0xFFF0F7FF),
                      border: Border.all(color: Color(0xFFe0efff))),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Add Photos".translate(context),
                              style: textStyle(18),
                            )
                          ],
                        ),
                        12.height,
                        Wrap(
                          children: [
                            Container(
                              width: 95,
                              height: 95,
                              decoration: boxDecorationDefault(
                                  boxShadow: [],
                                  color: UiColors.borderBlue,
                                  borderRadius: BorderRadius.circular(10)),
                              child: const Center(
                                child: Icon(Icons.add),
                              ),
                            ).paddingAll(4).onTap(() async {
                              final list = await ImagePicker().pickMultiImage();
                              if (list.isNotEmpty) {
                                // imageList.addAll(list);
                                for (var image in list) {
                                  await ref
                                      .read(uploadImageProvider.notifier)
                                      .uploadImage(
                                          image: image,
                                          type: ImageType.product);
                                }
                                setState(() {});
                              } else {}
                            }),
                            for (var i = 0; i < imageStringList.length; i++)
                              ImageWidget(
                                imagePath:
                                    "${getConfig().baseUrls?.productImageUrl}/${imageStringList[i]}",
                                onRemove: () {
                                  try {
                                    // imageStringList.remove(imageStringList[i]);
                                    imageStringList.remove(imageStringList[i]);
                                  } catch (e) {}
                                  setState(() {});
                                },
                              ),
                          ],
                        )
                      ])),
              12.height,
              Container(
                  decoration: boxDecorationDefault(
                      boxShadow: [],
                      color: Color(0xFFF0F7FF),
                      border: Border.all(color: Color(0xFFe0efff))),
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Add Thumbnail Photo".translate(context),
                              style: textStyle(18),
                            )
                          ],
                        ),
                        12.height,
                        Wrap(
                          children: [
                            thumbnailString == null
                                ? Container(
                                    width: 95,
                                    height: 95,
                                    decoration: boxDecorationDefault(
                                        boxShadow: [],
                                        color: UiColors.borderBlue,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: const Center(
                                      child: Icon(Icons.add),
                                    ),
                                  ).paddingAll(4).onTap(() async {
                                    final image = await ImagePicker()
                                        .pickImage(source: ImageSource.gallery);
                                    if (image != null) {
                                      // thumbnail = image;
                                      await ref
                                          .read(uploadImageProvider.notifier)
                                          .uploadImage(
                                              image: image,
                                              type: ImageType.thumbnail);
                                      setState(() {});
                                    }
                                  })
                                : ImageWidget(
                                    imagePath:
                                        "${getConfig().baseUrls?.productThumbnailUrl}/${thumbnailString}",
                                    onRemove: () {
                                      // thumbnail = null;
                                      thumbnailString = null;
                                      setState(() {});
                                    },
                                  )
                          ],
                        )
                      ])),
              52.height,
            ],
          ),
        ),
      ),
    );
  }
}

class PhoneOptionsWidget extends ConsumerWidget {
  const PhoneOptionsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Container(
          decoration: boxDecorationDefault(
            color: UiColors.white,
            boxShadow: [],
          ),
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              ref.watch(phoneOptionProvider).contains(0)
                  ? const Icon(
                      Icons.check_box,
                      color: UiColors.darkBlue,
                    )
                  : const Icon(
                      Icons.check_box_outline_blank,
                      color: UiColors.darkBlue,
                    ),
              10.width,
              Text(
                "Call".translate(context),
                style: textStyle(14),
              )
            ],
          ),
        ).onTap(() {
          ref.read(phoneOptionProvider.notifier).setCall();
        }),
        12.width,
        Container(
          decoration: boxDecorationDefault(
            color: UiColors.white,
            boxShadow: [],
          ),
          padding: EdgeInsets.all(8),
          child: Row(
            children: [
              ref.watch(phoneOptionProvider).contains(1)
                  ? const Icon(
                      Icons.check_box,
                      color: UiColors.darkBlue,
                    )
                  : const Icon(
                      Icons.check_box_outline_blank,
                      color: UiColors.darkBlue,
                    ),
              10.width,
              Text(
                "WhatsApp".translate(context),
                style: textStyle(14),
              )
            ],
          ),
        ).onTap(() {
          ref.read(phoneOptionProvider.notifier).setWhatsapp();
        }),
        12.width,
        Container(
          decoration: boxDecorationDefault(
            color: UiColors.white,
            boxShadow: [],
          ),
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              const Icon(
                Icons.check_box,
                color: UiColors.darkBlue,
              ),
              10.width,
              Text(
                "chat".translate(context),
                style: textStyle(14),
              )
            ],
          ),
        ),
        12.width,
      ],
    );
  }
}

class InputFieldWidget extends StatelessWidget {
  final String titleText;
  final TextEditingController controller;
  final String? hintText;
  final int? maxLines;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  const InputFieldWidget({
    super.key,
    required this.titleText,
    required this.controller,
    this.validator,
    this.hintText,
    this.maxLines,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: boxDecorationDefault(
          border: Border.all(color: UiColors.borderBlue),
          color: UiColors.bgBlue,
          boxShadow: []),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titleText,
            style: textStyle(16),
          ),
          12.height,
          TextFormField(
            maxLines: maxLines,
            validator: validator,
            controller: controller,
            keyboardType: keyboardType,
            decoration: whiteEditTextDecoration().copyWith(
              hintText: hintText,
              contentPadding: const EdgeInsets.only(
                  top: 11, right: 14, left: 14, bottom: 11),
            ),
          ),
        ],
      ),
    );
  }
}

class DropDownSelection extends StatelessWidget {
  final String title;
  final String value;
  final Function() onEdit;
  const DropDownSelection({
    super.key,
    required this.title,
    required this.value,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: boxDecorationDefault(
            border: Border.all(color: UiColors.borderBlue),
            color: UiColors.bgBlue,
            boxShadow: []),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: textStyle(18),
              ),
            ],
          ),
          12.height,
          Container(
              decoration: boxDecorationDefault(
                  boxShadow: [], borderRadius: BorderRadius.circular(50)),
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.radio_button_checked,
                        size: 20,
                        color: UiColors.darkBlue,
                      ),
                      8.width,
                      Text(
                        value,
                        style: textStyle(16).copyWith(color: UiColors.darkBlue),
                      ),
                    ],
                  ),
                  Icon(
                    Icons.edit_square,
                    color: UiColors.darkBlue,
                  ).onTap(onEdit)
                ],
              ))
        ]));
  }
}

class SelectLocationWidget extends StatelessWidget {
  final LocationAd location;
  const SelectLocationWidget({
    super.key,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: boxDecorationDefault(
          boxShadow: [],
          color: Color(0xFFF0F7FF),
          border: Border.all(color: Color(0xFFe0efff))),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "Location".translate(context),
                style: textStyle(18),
              )
            ],
          ),
          20.height,
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                  height: 156,
                  child: FlutterMap(
                    options: MapOptions(
                      initialCenter:
                          LatLng(location.latitude, location.longitude),
                      initialZoom: 12,
                    ),
                    children: [
                      TileLayer(
                        // urlTemplate:
                        //     'https://stamen-tiles.a.ssl.fastly.net/toner-background/{z}/{x}/{y}.png',
                        urlTemplate:
                            'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName: 'com.intelligentprojects.adyuser',
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                decoration: boxDecorationDefault(
                    boxShadow: [], color: Colors.white.withOpacity(0.2)),
                height: 156,
                child: Column(
                  children: [
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: boxDecorationDefault(
                              boxShadow: [],
                              color: Color(0xFFF0F7FF),
                              border: Border.all(color: Color(0xFF014bac)),
                              borderRadius: BorderRadius.circular(10)),
                          child: Text(
                            "Select Location".translate(context),
                            style: titilliumRegular.copyWith(
                                color: Color(0xFF014bac)),
                          ),
                        ).onTap(() {
                          ChooseLocationMap().launch(context);
                        }),
                      ],
                    ),
                    Spacer()
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class ImageWidget extends ConsumerWidget {
  final String imagePath;
  final void Function()? onRemove;
  const ImageWidget({
    super.key,
    required this.onRemove,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
            padding: const EdgeInsets.all(4.0),
            child: Stack(children: [
              CacheImage(
                height: 95,
                width: 95,
                image: imagePath,
                radius: 10,
              )
              // Container(
              //     width: 95,
              //     height: 95,
              //     decoration: const BoxDecoration(
              //         color: Colors.white,
              //         borderRadius: BorderRadius.all(Radius.circular(10))),
              //     child: ClipRRect(
              //         borderRadius: const BorderRadius.all(
              //             Radius.circular(Dimensions.paddingSizeDefault)),
              //         child: Image.file(File(imagePath),
              //             width: 100, height: 100, fit: BoxFit.cover))),
              ,
              Positioned(
                  top: 0,
                  right: 0,
                  child: InkWell(
                      onTap: onRemove,
                      child: Container(
                          decoration: BoxDecoration(
                              color: Theme.of(context).hintColor,
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(
                                      Dimensions.paddingSizeDefault))),
                          child: const Padding(
                              padding: EdgeInsets.all(4.0),
                              child: Icon(Icons.clear,
                                  color: Colors.white,
                                  size: Dimensions.iconSizeExtraSmall))))),
            ])),
      ],
    );
  }
}
