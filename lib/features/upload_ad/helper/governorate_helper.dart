import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sixvalley_ecommerce/features/ads/models/governorate_mode.dart';
import 'package:flutter_sixvalley_ecommerce/features/ads/models/wilaya_model.dart';
import 'package:flutter_sixvalley_ecommerce/features/upload_ad/helper/wilaya_helper.dart';
import 'package:flutter_sixvalley_ecommerce/theme/controllers/theme_controller.dart';

class GovernorateHelperNotifier extends StateNotifier<GovernorateModel?> {
  final StateNotifierProviderRef<GovernorateHelperNotifier, GovernorateModel?>
      ref;
  GovernorateHelperNotifier(this.ref) : super(null);
  set(GovernorateModel wilaya) {
    ref.read(wilayatHelperProvider.notifier).clear();
    state = wilaya;
  }

  clear() {
    state = null;
  }

  getName() => getLang() ? state?.name ?? null : state?.nameAr ?? null;
}

final governorateHelperProvider =
    StateNotifierProvider<GovernorateHelperNotifier, GovernorateModel?>((ref) {
  return GovernorateHelperNotifier(ref);
});
