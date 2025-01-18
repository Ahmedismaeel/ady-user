// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fields_by_category_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$fieldsByCateogryHash() => r'eac9e3f8c24b824e42637bc930b45af85c240f17';

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

/// See also [fieldsByCateogry].
@ProviderFor(fieldsByCateogry)
const fieldsByCateogryProvider = FieldsByCateogryFamily();

/// See also [fieldsByCateogry].
class FieldsByCateogryFamily
    extends Family<AsyncValue<List<FieldHelperModel>>> {
  /// See also [fieldsByCateogry].
  const FieldsByCateogryFamily();

  /// See also [fieldsByCateogry].
  FieldsByCateogryProvider call({
    required int categoryId,
  }) {
    return FieldsByCateogryProvider(
      categoryId: categoryId,
    );
  }

  @override
  FieldsByCateogryProvider getProviderOverride(
    covariant FieldsByCateogryProvider provider,
  ) {
    return call(
      categoryId: provider.categoryId,
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
  String? get name => r'fieldsByCateogryProvider';
}

/// See also [fieldsByCateogry].
class FieldsByCateogryProvider
    extends AutoDisposeFutureProvider<List<FieldHelperModel>> {
  /// See also [fieldsByCateogry].
  FieldsByCateogryProvider({
    required int categoryId,
  }) : this._internal(
          (ref) => fieldsByCateogry(
            ref as FieldsByCateogryRef,
            categoryId: categoryId,
          ),
          from: fieldsByCateogryProvider,
          name: r'fieldsByCateogryProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$fieldsByCateogryHash,
          dependencies: FieldsByCateogryFamily._dependencies,
          allTransitiveDependencies:
              FieldsByCateogryFamily._allTransitiveDependencies,
          categoryId: categoryId,
        );

  FieldsByCateogryProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.categoryId,
  }) : super.internal();

  final int categoryId;

  @override
  Override overrideWith(
    FutureOr<List<FieldHelperModel>> Function(FieldsByCateogryRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FieldsByCateogryProvider._internal(
        (ref) => create(ref as FieldsByCateogryRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        categoryId: categoryId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<FieldHelperModel>> createElement() {
    return _FieldsByCateogryProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FieldsByCateogryProvider && other.categoryId == categoryId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, categoryId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin FieldsByCateogryRef
    on AutoDisposeFutureProviderRef<List<FieldHelperModel>> {
  /// The parameter `categoryId` of this provider.
  int get categoryId;
}

class _FieldsByCateogryProviderElement
    extends AutoDisposeFutureProviderElement<List<FieldHelperModel>>
    with FieldsByCateogryRef {
  _FieldsByCateogryProviderElement(super.provider);

  @override
  int get categoryId => (origin as FieldsByCateogryProvider).categoryId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
