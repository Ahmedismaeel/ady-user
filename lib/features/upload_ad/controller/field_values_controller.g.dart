// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'field_values_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getfieldValuesHash() => r'b0753f08b58e6078848b792ea89cdcae7da6e9c0';

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

/// See also [getfieldValues].
@ProviderFor(getfieldValues)
const getfieldValuesProvider = GetfieldValuesFamily();

/// See also [getfieldValues].
class GetfieldValuesFamily extends Family<AsyncValue<List<FieldValueModel>>> {
  /// See also [getfieldValues].
  const GetfieldValuesFamily();

  /// See also [getfieldValues].
  GetfieldValuesProvider call({
    required int id,
    required int? parentId,
  }) {
    return GetfieldValuesProvider(
      id: id,
      parentId: parentId,
    );
  }

  @override
  GetfieldValuesProvider getProviderOverride(
    covariant GetfieldValuesProvider provider,
  ) {
    return call(
      id: provider.id,
      parentId: provider.parentId,
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
  String? get name => r'getfieldValuesProvider';
}

/// See also [getfieldValues].
class GetfieldValuesProvider
    extends AutoDisposeFutureProvider<List<FieldValueModel>> {
  /// See also [getfieldValues].
  GetfieldValuesProvider({
    required int id,
    required int? parentId,
  }) : this._internal(
          (ref) => getfieldValues(
            ref as GetfieldValuesRef,
            id: id,
            parentId: parentId,
          ),
          from: getfieldValuesProvider,
          name: r'getfieldValuesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getfieldValuesHash,
          dependencies: GetfieldValuesFamily._dependencies,
          allTransitiveDependencies:
              GetfieldValuesFamily._allTransitiveDependencies,
          id: id,
          parentId: parentId,
        );

  GetfieldValuesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
    required this.parentId,
  }) : super.internal();

  final int id;
  final int? parentId;

  @override
  Override overrideWith(
    FutureOr<List<FieldValueModel>> Function(GetfieldValuesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetfieldValuesProvider._internal(
        (ref) => create(ref as GetfieldValuesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
        parentId: parentId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<FieldValueModel>> createElement() {
    return _GetfieldValuesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetfieldValuesProvider &&
        other.id == id &&
        other.parentId == parentId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);
    hash = _SystemHash.combine(hash, parentId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetfieldValuesRef on AutoDisposeFutureProviderRef<List<FieldValueModel>> {
  /// The parameter `id` of this provider.
  int get id;

  /// The parameter `parentId` of this provider.
  int? get parentId;
}

class _GetfieldValuesProviderElement
    extends AutoDisposeFutureProviderElement<List<FieldValueModel>>
    with GetfieldValuesRef {
  _GetfieldValuesProviderElement(super.provider);

  @override
  int get id => (origin as GetfieldValuesProvider).id;
  @override
  int? get parentId => (origin as GetfieldValuesProvider).parentId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
