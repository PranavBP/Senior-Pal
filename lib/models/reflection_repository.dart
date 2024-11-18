// lib/models/reflection_repository.dart
import 'package:cloud_firestore/cloud_firestore.dart';

import 'reflection.dart';

class ReflectionRepository {
  final CollectionReference _reflectionsCollection =
      FirebaseFirestore.instance.collection('reflections');

  Future<void> addReflection(Reflection reflection) async {
    await _reflectionsCollection.add(reflection.toMap());
  }

  Future<void> updateReflection(Reflection reflection) async {
    await _reflectionsCollection.doc(reflection.id).update(reflection.toMap());
  }

  Future<void> deleteReflection(String reflectionId) async {
    await _reflectionsCollection.doc(reflectionId).delete();
  }

  Stream<List<Reflection>> getReflectionsStream() {
    return _reflectionsCollection.snapshots().map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return Reflection.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    });
  }
}
