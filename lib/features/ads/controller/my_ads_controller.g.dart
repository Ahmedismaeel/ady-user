// // GENERATED CODE - DO NOT MODIFY BY HAND

// part of 'my_ads_controller.dart';

// // **************************************************************************
// // RiverpodGenerator
// // **************************************************************************

// String _$myAdsHash() => r'dd47f90037ea75163e8956eec4679036fbaec509';

// /// Copied from Dart SDK
// class _SystemHash {
//   _SystemHash._();

//   static int combine(int hash, int value) {
//     // ignore: parameter_assignments
//     hash = 0x1fffffff & (hash + value);
//     // ignore: parameter_assignments
//     hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
//     return hash ^ (hash >> 6);
//   }

//   static int finish(int hash) {
//     // ignore: parameter_assignments
//     hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
//     // ignore: parameter_assignments
//     hash = hash ^ (hash >> 11);
//     return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
//   }
// }

// /// See also [myAds].
// @ProviderFor(myAds)
// const myAdsProvider = MyAdsFamily();

// /// See also [myAds].
// class MyAdsFamily extends Family<AsyncValue<List<Product>>> {
//   /// See also [myAds].
//   const MyAdsFamily();

//   /// See also [myAds].
//   MyAdsProvider call({
//     int? statusId,
//   }) {
//     return MyAdsProvider(
//       statusId: statusId,
//     );
//   }

//   @override
//   MyAdsProvider getProviderOverride(
//     covariant MyAdsProvider provider,
//   ) {
//     return call(
//       statusId: provider.statusId,
//     );
//   }

//   static const Iterable<ProviderOrFamily>? _dependencies = null;

//   @override
//   Iterable<ProviderOrFamily>? get dependencies => _dependencies;

//   static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

//   @override
//   Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
//       _allTransitiveDependencies;

//   @override
//   String? get name => r'myAdsProvider';
// }

// /// See also [myAds].
// class MyAdsProvider extends AutoDisposeFutureProvider<List<Product>> {
//   /// See also [myAds].
//   MyAdsProvider({
//     int? statusId,
//   }) : this._internal(
//           (ref) => myAds(
//             ref as MyAdsRef,
//             statusId: statusId,
//           ),
//           from: myAdsProvider,
//           name: r'myAdsProvider',
//           debugGetCreateSourceHash:
//               const bool.fromEnvironment('dart.vm.product')
//                   ? null
//                   : _$myAdsHash,
//           dependencies: MyAdsFamily._dependencies,
//           allTransitiveDependencies: MyAdsFamily._allTransitiveDependencies,
//           statusId: statusId,
//         );

//   MyAdsProvider._internal(
//     super._createNotifier, {
//     required super.name,
//     required super.dependencies,
//     required super.allTransitiveDependencies,
//     required super.debugGetCreateSourceHash,
//     required super.from,
//     required this.statusId,
//   }) : super.internal();

//   final int? statusId;

//   @override
//   Override overrideWith(
//     FutureOr<List<Product>> Function(MyAdsRef provider) create,
//   ) {
//     return ProviderOverride(
//       origin: this,
//       override: MyAdsProvider._internal(
//         (ref) => create(ref as MyAdsRef),
//         from: from,
//         name: null,
//         dependencies: null,
//         allTransitiveDependencies: null,
//         debugGetCreateSourceHash: null,
//         statusId: statusId,
//       ),
//     );
//   }

//   @override
//   AutoDisposeFutureProviderElement<List<Product>> createElement() {
//     return _MyAdsProviderElement(this);
//   }

//   @override
//   bool operator ==(Object other) {
//     return other is MyAdsProvider && other.statusId == statusId;
//   }

//   @override
//   int get hashCode {
//     var hash = _SystemHash.combine(0, runtimeType.hashCode);
//     hash = _SystemHash.combine(hash, statusId.hashCode);

//     return _SystemHash.finish(hash);
//   }
// }

// mixin MyAdsRef on AutoDisposeFutureProviderRef<List<Product>> {
//   /// The parameter `statusId` of this provider.
//   int? get statusId;
// }

// class _MyAdsProviderElement
//     extends AutoDisposeFutureProviderElement<List<Product>> with MyAdsRef {
//   _MyAdsProviderElement(super.provider);

//   @override
//   int? get statusId => (origin as MyAdsProvider).statusId;
// }
// // ignore_for_file: type=lint
// // ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
