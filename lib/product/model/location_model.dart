import 'package:equatable/equatable.dart';
import 'package:isar/isar.dart';

part 'location_model.g.dart';

@Collection(accessor: 'location', inheritance: false)
class LocationModel with EquatableMixin {
  final Id id;

  final double latitude;

  final double longitude;

  final double radius;

  final String title;

  final bool active;

  LocationModel({
    this.id = Isar.autoIncrement,
    required this.title,
    required this.latitude,
    required this.longitude,
    this.radius = 500,
    this.active = true,
  });

  LocationModel copyWith({
    Id? id,
    double? latitude,
    double? longitude,
    double? radius,
    String? title,
    bool? active,
  }) =>
      LocationModel(
        id: id ?? this.id,
        title: title ?? this.title,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        radius: radius ?? this.radius,
        active: active ?? this.active,
      );

  @ignore
  @override
  List<Object?> get props => [id, title, latitude, longitude, radius, active];
}
