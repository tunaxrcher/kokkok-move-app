// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ride.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Ride _$RideFromJson(Map<String, dynamic> json) {
  return _Ride.fromJson(json);
}

/// @nodoc
mixin _$Ride {
  String get id => throw _privateConstructorUsedError;
  Location get pickupLocation => throw _privateConstructorUsedError;
  Location get destination => throw _privateConstructorUsedError;
  RideStatus get status => throw _privateConstructorUsedError;
  Driver? get driver => throw _privateConstructorUsedError;
  double? get fare => throw _privateConstructorUsedError;
  double? get distance => throw _privateConstructorUsedError;
  int? get duration => throw _privateConstructorUsedError; // in minutes
  int? get estimatedArrival => throw _privateConstructorUsedError; // in minutes
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  DateTime? get completedAt => throw _privateConstructorUsedError;
  double? get rating => throw _privateConstructorUsedError;
  String? get review => throw _privateConstructorUsedError;

  /// Serializes this Ride to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Ride
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RideCopyWith<Ride> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RideCopyWith<$Res> {
  factory $RideCopyWith(Ride value, $Res Function(Ride) then) =
      _$RideCopyWithImpl<$Res, Ride>;
  @useResult
  $Res call({
    String id,
    Location pickupLocation,
    Location destination,
    RideStatus status,
    Driver? driver,
    double? fare,
    double? distance,
    int? duration,
    int? estimatedArrival,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? completedAt,
    double? rating,
    String? review,
  });

  $LocationCopyWith<$Res> get pickupLocation;
  $LocationCopyWith<$Res> get destination;
  $DriverCopyWith<$Res>? get driver;
}

/// @nodoc
class _$RideCopyWithImpl<$Res, $Val extends Ride>
    implements $RideCopyWith<$Res> {
  _$RideCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Ride
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? pickupLocation = null,
    Object? destination = null,
    Object? status = null,
    Object? driver = freezed,
    Object? fare = freezed,
    Object? distance = freezed,
    Object? duration = freezed,
    Object? estimatedArrival = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? completedAt = freezed,
    Object? rating = freezed,
    Object? review = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            pickupLocation: null == pickupLocation
                ? _value.pickupLocation
                : pickupLocation // ignore: cast_nullable_to_non_nullable
                      as Location,
            destination: null == destination
                ? _value.destination
                : destination // ignore: cast_nullable_to_non_nullable
                      as Location,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as RideStatus,
            driver: freezed == driver
                ? _value.driver
                : driver // ignore: cast_nullable_to_non_nullable
                      as Driver?,
            fare: freezed == fare
                ? _value.fare
                : fare // ignore: cast_nullable_to_non_nullable
                      as double?,
            distance: freezed == distance
                ? _value.distance
                : distance // ignore: cast_nullable_to_non_nullable
                      as double?,
            duration: freezed == duration
                ? _value.duration
                : duration // ignore: cast_nullable_to_non_nullable
                      as int?,
            estimatedArrival: freezed == estimatedArrival
                ? _value.estimatedArrival
                : estimatedArrival // ignore: cast_nullable_to_non_nullable
                      as int?,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            updatedAt: freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            completedAt: freezed == completedAt
                ? _value.completedAt
                : completedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            rating: freezed == rating
                ? _value.rating
                : rating // ignore: cast_nullable_to_non_nullable
                      as double?,
            review: freezed == review
                ? _value.review
                : review // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of Ride
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LocationCopyWith<$Res> get pickupLocation {
    return $LocationCopyWith<$Res>(_value.pickupLocation, (value) {
      return _then(_value.copyWith(pickupLocation: value) as $Val);
    });
  }

  /// Create a copy of Ride
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LocationCopyWith<$Res> get destination {
    return $LocationCopyWith<$Res>(_value.destination, (value) {
      return _then(_value.copyWith(destination: value) as $Val);
    });
  }

  /// Create a copy of Ride
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DriverCopyWith<$Res>? get driver {
    if (_value.driver == null) {
      return null;
    }

    return $DriverCopyWith<$Res>(_value.driver!, (value) {
      return _then(_value.copyWith(driver: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$RideImplCopyWith<$Res> implements $RideCopyWith<$Res> {
  factory _$$RideImplCopyWith(
    _$RideImpl value,
    $Res Function(_$RideImpl) then,
  ) = __$$RideImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    Location pickupLocation,
    Location destination,
    RideStatus status,
    Driver? driver,
    double? fare,
    double? distance,
    int? duration,
    int? estimatedArrival,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? completedAt,
    double? rating,
    String? review,
  });

  @override
  $LocationCopyWith<$Res> get pickupLocation;
  @override
  $LocationCopyWith<$Res> get destination;
  @override
  $DriverCopyWith<$Res>? get driver;
}

/// @nodoc
class __$$RideImplCopyWithImpl<$Res>
    extends _$RideCopyWithImpl<$Res, _$RideImpl>
    implements _$$RideImplCopyWith<$Res> {
  __$$RideImplCopyWithImpl(_$RideImpl _value, $Res Function(_$RideImpl) _then)
    : super(_value, _then);

  /// Create a copy of Ride
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? pickupLocation = null,
    Object? destination = null,
    Object? status = null,
    Object? driver = freezed,
    Object? fare = freezed,
    Object? distance = freezed,
    Object? duration = freezed,
    Object? estimatedArrival = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? completedAt = freezed,
    Object? rating = freezed,
    Object? review = freezed,
  }) {
    return _then(
      _$RideImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        pickupLocation: null == pickupLocation
            ? _value.pickupLocation
            : pickupLocation // ignore: cast_nullable_to_non_nullable
                  as Location,
        destination: null == destination
            ? _value.destination
            : destination // ignore: cast_nullable_to_non_nullable
                  as Location,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as RideStatus,
        driver: freezed == driver
            ? _value.driver
            : driver // ignore: cast_nullable_to_non_nullable
                  as Driver?,
        fare: freezed == fare
            ? _value.fare
            : fare // ignore: cast_nullable_to_non_nullable
                  as double?,
        distance: freezed == distance
            ? _value.distance
            : distance // ignore: cast_nullable_to_non_nullable
                  as double?,
        duration: freezed == duration
            ? _value.duration
            : duration // ignore: cast_nullable_to_non_nullable
                  as int?,
        estimatedArrival: freezed == estimatedArrival
            ? _value.estimatedArrival
            : estimatedArrival // ignore: cast_nullable_to_non_nullable
                  as int?,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        updatedAt: freezed == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        completedAt: freezed == completedAt
            ? _value.completedAt
            : completedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        rating: freezed == rating
            ? _value.rating
            : rating // ignore: cast_nullable_to_non_nullable
                  as double?,
        review: freezed == review
            ? _value.review
            : review // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RideImpl implements _Ride {
  const _$RideImpl({
    required this.id,
    required this.pickupLocation,
    required this.destination,
    required this.status,
    this.driver,
    this.fare,
    this.distance,
    this.duration,
    this.estimatedArrival,
    this.createdAt,
    this.updatedAt,
    this.completedAt,
    this.rating,
    this.review,
  });

  factory _$RideImpl.fromJson(Map<String, dynamic> json) =>
      _$$RideImplFromJson(json);

  @override
  final String id;
  @override
  final Location pickupLocation;
  @override
  final Location destination;
  @override
  final RideStatus status;
  @override
  final Driver? driver;
  @override
  final double? fare;
  @override
  final double? distance;
  @override
  final int? duration;
  // in minutes
  @override
  final int? estimatedArrival;
  // in minutes
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final DateTime? completedAt;
  @override
  final double? rating;
  @override
  final String? review;

  @override
  String toString() {
    return 'Ride(id: $id, pickupLocation: $pickupLocation, destination: $destination, status: $status, driver: $driver, fare: $fare, distance: $distance, duration: $duration, estimatedArrival: $estimatedArrival, createdAt: $createdAt, updatedAt: $updatedAt, completedAt: $completedAt, rating: $rating, review: $review)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RideImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.pickupLocation, pickupLocation) ||
                other.pickupLocation == pickupLocation) &&
            (identical(other.destination, destination) ||
                other.destination == destination) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.driver, driver) || other.driver == driver) &&
            (identical(other.fare, fare) || other.fare == fare) &&
            (identical(other.distance, distance) ||
                other.distance == distance) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.estimatedArrival, estimatedArrival) ||
                other.estimatedArrival == estimatedArrival) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.review, review) || other.review == review));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    pickupLocation,
    destination,
    status,
    driver,
    fare,
    distance,
    duration,
    estimatedArrival,
    createdAt,
    updatedAt,
    completedAt,
    rating,
    review,
  );

  /// Create a copy of Ride
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RideImplCopyWith<_$RideImpl> get copyWith =>
      __$$RideImplCopyWithImpl<_$RideImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RideImplToJson(this);
  }
}

abstract class _Ride implements Ride {
  const factory _Ride({
    required final String id,
    required final Location pickupLocation,
    required final Location destination,
    required final RideStatus status,
    final Driver? driver,
    final double? fare,
    final double? distance,
    final int? duration,
    final int? estimatedArrival,
    final DateTime? createdAt,
    final DateTime? updatedAt,
    final DateTime? completedAt,
    final double? rating,
    final String? review,
  }) = _$RideImpl;

  factory _Ride.fromJson(Map<String, dynamic> json) = _$RideImpl.fromJson;

  @override
  String get id;
  @override
  Location get pickupLocation;
  @override
  Location get destination;
  @override
  RideStatus get status;
  @override
  Driver? get driver;
  @override
  double? get fare;
  @override
  double? get distance;
  @override
  int? get duration; // in minutes
  @override
  int? get estimatedArrival; // in minutes
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  DateTime? get completedAt;
  @override
  double? get rating;
  @override
  String? get review;

  /// Create a copy of Ride
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RideImplCopyWith<_$RideImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FareEstimate _$FareEstimateFromJson(Map<String, dynamic> json) {
  return _FareEstimate.fromJson(json);
}

/// @nodoc
mixin _$FareEstimate {
  double get baseFare => throw _privateConstructorUsedError;
  double get distanceFare => throw _privateConstructorUsedError;
  double get timeFare => throw _privateConstructorUsedError;
  double get totalFare => throw _privateConstructorUsedError;
  double get distance => throw _privateConstructorUsedError;
  int get estimatedDuration => throw _privateConstructorUsedError;
  String? get currency => throw _privateConstructorUsedError;

  /// Serializes this FareEstimate to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FareEstimate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FareEstimateCopyWith<FareEstimate> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FareEstimateCopyWith<$Res> {
  factory $FareEstimateCopyWith(
    FareEstimate value,
    $Res Function(FareEstimate) then,
  ) = _$FareEstimateCopyWithImpl<$Res, FareEstimate>;
  @useResult
  $Res call({
    double baseFare,
    double distanceFare,
    double timeFare,
    double totalFare,
    double distance,
    int estimatedDuration,
    String? currency,
  });
}

/// @nodoc
class _$FareEstimateCopyWithImpl<$Res, $Val extends FareEstimate>
    implements $FareEstimateCopyWith<$Res> {
  _$FareEstimateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FareEstimate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? baseFare = null,
    Object? distanceFare = null,
    Object? timeFare = null,
    Object? totalFare = null,
    Object? distance = null,
    Object? estimatedDuration = null,
    Object? currency = freezed,
  }) {
    return _then(
      _value.copyWith(
            baseFare: null == baseFare
                ? _value.baseFare
                : baseFare // ignore: cast_nullable_to_non_nullable
                      as double,
            distanceFare: null == distanceFare
                ? _value.distanceFare
                : distanceFare // ignore: cast_nullable_to_non_nullable
                      as double,
            timeFare: null == timeFare
                ? _value.timeFare
                : timeFare // ignore: cast_nullable_to_non_nullable
                      as double,
            totalFare: null == totalFare
                ? _value.totalFare
                : totalFare // ignore: cast_nullable_to_non_nullable
                      as double,
            distance: null == distance
                ? _value.distance
                : distance // ignore: cast_nullable_to_non_nullable
                      as double,
            estimatedDuration: null == estimatedDuration
                ? _value.estimatedDuration
                : estimatedDuration // ignore: cast_nullable_to_non_nullable
                      as int,
            currency: freezed == currency
                ? _value.currency
                : currency // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$FareEstimateImplCopyWith<$Res>
    implements $FareEstimateCopyWith<$Res> {
  factory _$$FareEstimateImplCopyWith(
    _$FareEstimateImpl value,
    $Res Function(_$FareEstimateImpl) then,
  ) = __$$FareEstimateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    double baseFare,
    double distanceFare,
    double timeFare,
    double totalFare,
    double distance,
    int estimatedDuration,
    String? currency,
  });
}

/// @nodoc
class __$$FareEstimateImplCopyWithImpl<$Res>
    extends _$FareEstimateCopyWithImpl<$Res, _$FareEstimateImpl>
    implements _$$FareEstimateImplCopyWith<$Res> {
  __$$FareEstimateImplCopyWithImpl(
    _$FareEstimateImpl _value,
    $Res Function(_$FareEstimateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FareEstimate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? baseFare = null,
    Object? distanceFare = null,
    Object? timeFare = null,
    Object? totalFare = null,
    Object? distance = null,
    Object? estimatedDuration = null,
    Object? currency = freezed,
  }) {
    return _then(
      _$FareEstimateImpl(
        baseFare: null == baseFare
            ? _value.baseFare
            : baseFare // ignore: cast_nullable_to_non_nullable
                  as double,
        distanceFare: null == distanceFare
            ? _value.distanceFare
            : distanceFare // ignore: cast_nullable_to_non_nullable
                  as double,
        timeFare: null == timeFare
            ? _value.timeFare
            : timeFare // ignore: cast_nullable_to_non_nullable
                  as double,
        totalFare: null == totalFare
            ? _value.totalFare
            : totalFare // ignore: cast_nullable_to_non_nullable
                  as double,
        distance: null == distance
            ? _value.distance
            : distance // ignore: cast_nullable_to_non_nullable
                  as double,
        estimatedDuration: null == estimatedDuration
            ? _value.estimatedDuration
            : estimatedDuration // ignore: cast_nullable_to_non_nullable
                  as int,
        currency: freezed == currency
            ? _value.currency
            : currency // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$FareEstimateImpl implements _FareEstimate {
  const _$FareEstimateImpl({
    required this.baseFare,
    required this.distanceFare,
    required this.timeFare,
    required this.totalFare,
    required this.distance,
    required this.estimatedDuration,
    this.currency,
  });

  factory _$FareEstimateImpl.fromJson(Map<String, dynamic> json) =>
      _$$FareEstimateImplFromJson(json);

  @override
  final double baseFare;
  @override
  final double distanceFare;
  @override
  final double timeFare;
  @override
  final double totalFare;
  @override
  final double distance;
  @override
  final int estimatedDuration;
  @override
  final String? currency;

  @override
  String toString() {
    return 'FareEstimate(baseFare: $baseFare, distanceFare: $distanceFare, timeFare: $timeFare, totalFare: $totalFare, distance: $distance, estimatedDuration: $estimatedDuration, currency: $currency)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FareEstimateImpl &&
            (identical(other.baseFare, baseFare) ||
                other.baseFare == baseFare) &&
            (identical(other.distanceFare, distanceFare) ||
                other.distanceFare == distanceFare) &&
            (identical(other.timeFare, timeFare) ||
                other.timeFare == timeFare) &&
            (identical(other.totalFare, totalFare) ||
                other.totalFare == totalFare) &&
            (identical(other.distance, distance) ||
                other.distance == distance) &&
            (identical(other.estimatedDuration, estimatedDuration) ||
                other.estimatedDuration == estimatedDuration) &&
            (identical(other.currency, currency) ||
                other.currency == currency));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    baseFare,
    distanceFare,
    timeFare,
    totalFare,
    distance,
    estimatedDuration,
    currency,
  );

  /// Create a copy of FareEstimate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FareEstimateImplCopyWith<_$FareEstimateImpl> get copyWith =>
      __$$FareEstimateImplCopyWithImpl<_$FareEstimateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FareEstimateImplToJson(this);
  }
}

abstract class _FareEstimate implements FareEstimate {
  const factory _FareEstimate({
    required final double baseFare,
    required final double distanceFare,
    required final double timeFare,
    required final double totalFare,
    required final double distance,
    required final int estimatedDuration,
    final String? currency,
  }) = _$FareEstimateImpl;

  factory _FareEstimate.fromJson(Map<String, dynamic> json) =
      _$FareEstimateImpl.fromJson;

  @override
  double get baseFare;
  @override
  double get distanceFare;
  @override
  double get timeFare;
  @override
  double get totalFare;
  @override
  double get distance;
  @override
  int get estimatedDuration;
  @override
  String? get currency;

  /// Create a copy of FareEstimate
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FareEstimateImplCopyWith<_$FareEstimateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
