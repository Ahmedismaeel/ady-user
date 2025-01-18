// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plan_list_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$planListHash() => r'8eab340289d0a5919d8778342d1349a2ecd47709';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [planList].
@ProviderFor(planList)
const planListProvider = PlanListFamily();

/// See also [planList].
class PlanListFamily extends Family<AsyncValue<List<PlanModel>>> {
  /// See also [planList].
  const PlanListFamily();

  /// See also [planList].
  PlanListProvider call({
    required int categoryId,
    required int type,
  }) {
    return PlanListProvider(
      categoryId: categoryId,
      type: type,
    );
  }

  @override
  PlanListProvider getProviderOverride(
    covariant PlanListProvider provider,
  ) {
    return call(
      categoryId: provider.categoryId,
      type: provider.type,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'planListProvider';
}

/// See also [planList].
class PlanListProvider extends AutoDisposeFutureProvider<List<PlanModel>> {
  /// See also [planList].
  PlanListProvider({
    required int categoryId,
    required int type,
  }) : this._internal(
          (ref) => planList(
            ref as PlanListRef,
            categoryId: categoryId,
            type: type,
          ),
          from: planListProvider,
          name: r'planListProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$planListHash,
          dependencies: PlanListFamily._dependencies,
          allTransitiveDependencies: PlanListFamily._allTransitiveDependencies,
          categoryId: categoryId,
          type: type,
        );

  PlanListProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.categoryId,
    required this.type,
  }) : super.internal();

  final int categoryId;
  final int type;

  @override
  Override overrideWith(
    FutureOr<List<PlanModel>> Function(PlanListRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: PlanListProvider._internal(
        (ref) => create(ref as PlanListRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        categoryId: categoryId,
        type: type,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<PlanModel>> createElement() {
    return _PlanListProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PlanListProvider &&
        other.categoryId == categoryId &&
        other.type == type;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, categoryId.hashCode);
    hash = _SystemHash.combine(hash, type.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin PlanListRef on AutoDisposeFutureProviderRef<List<PlanModel>> {
  /// The parameter `categoryId` of this provider.
  int get categoryId;

  /// The parameter `type` of this provider.
  int get type;
}

class _PlanListProviderElement
    extends AutoDisposeFutureProviderElement<List<PlanModel>> with PlanListRef {
  _PlanListProviderElement(super.provider);

  @override
  int get categoryId => (origin as PlanListProvider).categoryId;
  @override
  int get type => (origin as PlanListProvider).type;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
