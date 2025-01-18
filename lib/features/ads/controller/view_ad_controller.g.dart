// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'view_ad_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$viewAdControllerHash() => r'16db8a987c7e5d33ab762772bb01e0b819fa0918';

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

/// See also [viewAdController].
@ProviderFor(viewAdController)
const viewAdControllerProvider = ViewAdControllerFamily();

/// See also [viewAdController].
class ViewAdControllerFamily extends Family<AsyncValue<dynamic>> {
  /// See also [viewAdController].
  const ViewAdControllerFamily();

  /// See also [viewAdController].
  ViewAdControllerProvider call({
    required dynamic id,
  }) {
    return ViewAdControllerProvider(
      id: id,
    );
  }

  @override
  ViewAdControllerProvider getProviderOverride(
    covariant ViewAdControllerProvider provider,
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
  String? get name => r'viewAdControllerProvider';
}

/// See also [viewAdController].
class ViewAdControllerProvider extends AutoDisposeFutureProvider<dynamic> {
  /// See also [viewAdController].
  ViewAdControllerProvider({
    required dynamic id,
  }) : this._internal(
          (ref) => viewAdController(
            ref as ViewAdControllerRef,
            id: id,
          ),
          from: viewAdControllerProvider,
          name: r'viewAdControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$viewAdControllerHash,
          dependencies: ViewAdControllerFamily._dependencies,
          allTransitiveDependencies:
              ViewAdControllerFamily._allTransitiveDependencies,
          id: id,
        );

  ViewAdControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final dynamic id;

  @override
  Override overrideWith(
    FutureOr<dynamic> Function(ViewAdControllerRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ViewAdControllerProvider._internal(
        (ref) => create(ref as ViewAdControllerRef),
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
  AutoDisposeFutureProviderElement<dynamic> createElement() {
    return _ViewAdControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ViewAdControllerProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ViewAdControllerRef on AutoDisposeFutureProviderRef<dynamic> {
  /// The parameter `id` of this provider.
  dynamic get id;
}

class _ViewAdControllerProviderElement
    extends AutoDisposeFutureProviderElement<dynamic> with ViewAdControllerRef {
  _ViewAdControllerProviderElement(super.provider);

  @override
  dynamic get id => (origin as ViewAdControllerProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
