import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/reflection.dart';

// StateNotifier to manage the list of reflections
class ReflectionListNotifier extends StateNotifier<List<Reflection>> {
  ReflectionListNotifier() : super([]);

  void addReflection(Reflection reflection) {
    state = [...state, reflection];
  }

  void updateReflection(Reflection updatedReflection) {
    state = [
      for (final reflection in state)
        if (reflection.id == updatedReflection.id)
          updatedReflection
        else
          reflection
    ];
  }

  void removeReflection(String id) {
    state = state.where((reflection) => reflection.id != id).toList();
  }
}

// Provider for the list of reflections
final reflectionListProvider =
    StateNotifierProvider<ReflectionListNotifier, List<Reflection>>(
        (ref) => ReflectionListNotifier());
