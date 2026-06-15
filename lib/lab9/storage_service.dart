import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

import 'person.dart';

class StorageService {
  // In-memory fallback for Web/DartPad or when native plugins are not loaded
  static List<Person>? _inMemoryPeople;

  Future<File?> _localFile() async {
    if (kIsWeb) return null;
    try {
      final dir = await getApplicationDocumentsDirectory();
      return File('${dir.path}/people.json');
    } catch (e) {
      debugPrint('Local storage not supported or not compiled: $e');
      return null;
    }
  }

  Future<List<Person>> loadPeople() async {
    // If on Web or fallback is active, use in-memory storage
    if (kIsWeb) {
      if (_inMemoryPeople != null) {
        return _inMemoryPeople!;
      }
      final assetData = await rootBundle.loadString('assets/data/people.json');
      final List data = jsonDecode(assetData);
      _inMemoryPeople = data.map((e) => Person.fromJson(e)).toList();
      return _inMemoryPeople!;
    }

    try {
      final file = await _localFile();
      if (file == null) {
        throw UnsupportedError('Local file storage is not available');
      }

      if (!await file.exists()) {
        final assetData = await rootBundle.loadString('assets/data/people.json');
        await file.writeAsString(assetData);
      }

      final jsonString = await file.readAsString();
      final List data = jsonDecode(jsonString);

      return data.map((e) => Person.fromJson(e)).toList();
    } catch (e) {
      debugPrint('Falling back to in-memory storage due to error: $e');
      if (_inMemoryPeople != null) {
        return _inMemoryPeople!;
      }
      final assetData = await rootBundle.loadString('assets/data/people.json');
      final List data = jsonDecode(assetData);
      _inMemoryPeople = data.map((e) => Person.fromJson(e)).toList();
      return _inMemoryPeople!;
    }
  }

  Future<void> savePeople(List<Person> people) async {
    // Always update the in-memory store
    _inMemoryPeople = List.from(people);

    if (kIsWeb) return;

    try {
      final file = await _localFile();
      if (file == null) return;

      final jsonString = jsonEncode(
        people.map((e) => e.toJson()).toList(),
      );

      await file.writeAsString(jsonString);
    } catch (e) {
      debugPrint('Failed to save to local file, saved to in-memory: $e');
    }
  }
}