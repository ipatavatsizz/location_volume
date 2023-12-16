import 'package:location_volume/product/model/location_model.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

enum FilterModel { test }

class DatabaseService {
  DatabaseService._private();

  static final DatabaseService _instance = DatabaseService._private();
  static DatabaseService get instance => _instance;

  static Isar? service;

  static Future<void> ensureInitialized({
    List<CollectionSchema<dynamic>> schemas = const [],
  }) async {
    await Isar.initializeIsarCore(download: true);
    final directory = await getApplicationDocumentsDirectory();
    service = await Isar.open(schemas, directory: directory.path);
  }

  Future<void> putLocation(LocationModel locationModel) async {
    await service!
        .writeTxn(() async => await service!.location.put(locationModel));
  }

  Future<void> putLocations(List<LocationModel> locationModel) async {
    await service!
        .writeTxn(() async => await service!.location.putAll(locationModel));
  }

  Future<LocationModel?> getLocation(int id) async {
    return await service!.writeTxn(() async => await service!.location.get(id));
  }

  Future<List<LocationModel?>> getLocations(int id) async {
    return await service!
        .writeTxn(() async => await service!.location.where().findAll());
  }

  Future<void> deleteLocation(int id) async {
    return await service!
        .writeTxn(() async => await service!.location.delete(id));
  }

  Future<void> deleteLocations(List<int> id) async {
    return await service!
        .writeTxn(() async => await service!.location.deleteAll(id));
  }
}
