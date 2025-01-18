import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sixvalley_ecommerce/data/datasource/remote/dio/share_preferance.dart';
import 'package:flutter_sixvalley_ecommerce/features/more/models/view_model.dart';
import 'package:flutter_sixvalley_ecommerce/utill/api_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/app_constants.dart';

final viewsProvider = AutoDisposeFutureProvider<ViewsModel>((ref) async {
  // "viewsProvider???????>>>>".log();
  // SharedPreferenceHelper.instance.getToken()?.log();
  return await AppConstants.getViews.get(fromJson: ViewsModel.fromJson);
});
