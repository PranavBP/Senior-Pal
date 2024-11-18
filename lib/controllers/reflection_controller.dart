// lib/controllers/reflection_controller.dart
import 'package:flutter/material.dart';
import '../models/reflection.dart';
import '../models/reflection_repository.dart';

class ReflectionController extends ChangeNotifier {
  final ReflectionRepository _reflectionRepository = ReflectionRepository();
  List<Reflection> reflections = [];

  ReflectionController() {
    _reflectionRepository.getReflectionsStream().listen((reflectionList) {
      reflections = reflectionList;
      notifyListeners();
    });
  }

  Future<void> addReflection(Reflection reflection) async {
    await _reflectionRepository.addReflection(reflection);
  }

  Future<void> updateReflection(Reflection reflection) async {
    await _reflectionRepository.updateReflection(reflection);
  }

  Future<void> deleteReflection(String reflectionId) async {
    await _reflectionRepository.deleteReflection(reflectionId);
  }
}
