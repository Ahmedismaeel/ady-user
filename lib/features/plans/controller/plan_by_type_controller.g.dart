// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plan_by_type_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$planListByTypeHash() => r'8c0726639d68fa958fa9adbe2222fe9eb8b84d13';

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

/// See also [planListByType].
@ProviderFor(planListByType)
const planListByTypeProvider = PlanListByTypeFamily();

/// See also [planListByType].
class PlanListByTypeFamily extends Family<AsyncValue<List<PlanModel>>> {
  /// See also [planListByType].
  const PlanListByTypeFamily();

  /// See also [planListByType].
  PlanListByTypeProvider call({
    required int id,
  }) {
    return PlanListByTypeProvider(
      id: id,
    );
  }

  @override
  PlanListByTypeProvider getProviderOverride(
    covariant PlanListByTypeProvider provider,
  ) {
    return call(
      id: provider.id,
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
  String? get name => r'planListByTypeProvider';
}

/// See also [planListByType].
class PlanListByTypeProvider
    extends AutoDisposeFutureProvider<List<PlanModel>> {
  /// See also [planListByType].
  PlanListByTypeProvider({
    required int id,
  }) : this._internal(
          (ref) => planListByType(
            ref as PlanListByTypeRef,
            id: id,
          ),
          from: planListByTypeProvider,
          name: r'planListByTypeProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$planListByTypeHash,
          dependencies: PlanListByTypeFamily._dependencies,
          allTransitiveDependencies:
              PlanListByTypeFamily._allTransitiveDependencies,
          id: id,
        );

  PlanListByTypeProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final int id;

  @override
  Override overrideWith(
    FutureOr<List<PlanModel>> Function(PlanListByTypeRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: PlanListByTypeProvider._internal(
        (ref) => create(ref as PlanListByTypeRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<PlanModel>> createElement() {
    return _PlanListByTypeProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PlanListByTypeProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin PlanListByTypeRef on AutoDisposeFutureProviderRef<List<PlanModel>> {
  /// The parameter `id` of this provider.
  int get id;
}

class _PlanListByTypeProviderElement
    extends AutoDisposeFutureProviderElement<List<PlanModel>>
    with PlanListByTypeRef {
  _PlanListByTypeProviderElement(super.provider);

  @override
  int get id => (origin as PlanListByTypeProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
