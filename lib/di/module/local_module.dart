import 'dart:async';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/encryption/xxtea.dart';

abstract class LocalModule {
  /// A singleton preference provider.
  ///
  /// Calling it multiple times will return the same instance.
  static Future<SharedPreferences> provideSharedPreferences() {
    return SharedPreferences.getInstance();
  }

  /// A singleton database provider.
  ///
  /// Calling it multiple times will return the same instance.
  static Future<Database> provideDatabase() async {
    // Key for encryption
    var encryptionKey = "";

    final appDocumentDir = await getApplicationDocumentsDirectory();

    final dbPath = join(appDocumentDir.path, 'emp');
    Database database;
    if (encryptionKey.isNotEmpty) {
      var codec = getXXTeaCodec(password: encryptionKey);
      database = await databaseFactoryIo.openDatabase(dbPath, codec: codec);
    } else {
      database = await databaseFactoryIo.openDatabase(dbPath);
    }

    return database;
  }
}
