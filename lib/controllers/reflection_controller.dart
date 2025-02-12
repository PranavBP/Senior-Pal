// // lib/controllers/reflection_controller.dart
// //------current code without db----//
// import 'package:flutter/material.dart';
// import '../models/reflection.dart';
// import '../models/reflection_repository.dart';

// class ReflectionController extends ChangeNotifier {
//   final ReflectionRepository _reflectionRepository = ReflectionRepository();
//   List<Reflection> reflections = [];

//   ReflectionController() {
//     _reflectionRepository.getReflectionsStream().listen((reflectionList) {
//       reflections = reflectionList;
//       notifyListeners();
//     });
//   }

//   Future<void> addReflection(Reflection reflection) async {
//     await _reflectionRepository.addReflection(reflection);
//   }

//   Future<void> updateReflection(Reflection reflection) async {
//     await _reflectionRepository.updateReflection(reflection);
//   }

//   Future<void> deleteReflection(String reflectionId) async {
//     await _reflectionRepository.deleteReflection(reflectionId);
//   }
// }

//------new code------//
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/reflection.dart';
import '../models/reflection_repository.dart';

class ReflectionController extends ChangeNotifier {
  final ReflectionRepository _reflectionRepository = ReflectionRepository();
  List<Reflection> reflections = [];

  /// Constructor to fetch reflections in real-time
  ReflectionController() {
    _fetchReflections();
  }

  /// Fetches reflections from Firebase in real-time
  void _fetchReflections() {
    _reflectionRepository.getReflectionsStream().listen((reflectionList) {
      reflections = reflectionList;
      notifyListeners();
    });
  }

  /// Adds a new reflection
  Future<void> addReflection(Reflection reflection) async {
    try {
      await _reflectionRepository.addReflection(reflection);
    } catch (e) {
      debugPrint("Error adding reflection: $e");
    }
  }

  /// Updates an existing reflection
  Future<void> updateReflection(Reflection reflection) async {
    try {
      await _reflectionRepository.updateReflection(reflection);
    } catch (e) {
      debugPrint("Error updating reflection: $e");
    }
  }

  /// Deletes a reflection
  Future<void> deleteReflection(String reflectionId) async {
    try {
      await _reflectionRepository.deleteReflection(reflectionId);
    } catch (e) {
      debugPrint("Error deleting reflection: $e");
    }
  }
}

/// ✅ Move `reflectionControllerProvider` outside the class
final reflectionControllerProvider =
    ChangeNotifierProvider<ReflectionController>((ref) {
  return ReflectionController();
});
