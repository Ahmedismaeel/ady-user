// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_add_field_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getAddFieldListHash() => r'ead5bcf1165e135b7237ff65cdbad6ac4d68ad5f';

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

/// See also [getAddFieldList].
@ProviderFor(getAddFieldList)
const getAddFieldListProvider = GetAddFieldListFamily();

/// See also [getAddFieldList].
class GetAddFieldListFamily extends Family<AsyncValue<List<AdFieldModel>>> {
  /// See also [getAddFieldList].
  const GetAddFieldListFamily();

  /// See also [getAddFieldList].
  GetAddFieldListProvider call({
    required int adId,
  }) {
    return GetAddFieldListProvider(
      adId: adId,
    );
  }

  @override
  GetAddFieldListProvider getProviderOverride(
    covariant GetAddFieldListProvider provider,
  ) {
    return call(
      adId: provider.adId,
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
  String? get name => r'getAddFieldListProvider';
}

/// See also [getAddFieldList].
class GetAddFieldListProvider
    extends AutoDisposeFutureProvider<List<AdFieldModel>> {
  /// See also [getAddFieldList].
  GetAddFieldListProvider({
    required int adId,
  }) : this._internal(
          (ref) => getAddFieldList(
            ref as GetAddFieldListRef,
            adId: adId,
          ),
          from: getAddFieldListProvider,
          name: r'getAddFieldListProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getAddFieldListHash,
          dependencies: GetAddFieldListFamily._dependencies,
          allTransitiveDependencies:
              GetAddFieldListFamily._allTransitiveDependencies,
          adId: adId,
        );

  GetAddFieldListProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.adId,
  }) : super.internal();

  final int adId;

  @override
  Override overrideWith(
    FutureOr<List<AdFieldModel>> Function(GetAddFieldListRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetAddFieldListProvider._internal(
        (ref) => create(ref as GetAddFieldListRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        adId: adId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<AdFieldModel>> createElement() {
    return _GetAddFieldListProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetAddFieldListProvider && other.adId == adId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, adId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetAddFieldListRef on AutoDisposeFutureProviderRef<List<AdFieldModel>> {
  /// The parameter `adId` of this provider.
  int get adId;
}

class _GetAddFieldListProviderElement
    extends AutoDisposeFutureProviderElement<List<AdFieldModel>>
    with GetAddFieldListRef {
  _GetAddFieldListProviderElement(super.provider);

  @override
  int get adId => (origin as GetAddFieldListProvider).adId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
