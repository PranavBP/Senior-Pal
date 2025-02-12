// // lib/models/reflection_repository.dart
// //-----current code without dB-----//
// import 'package:cloud_firestore/cloud_firestore.dart';

// import 'reflection.dart';

// class ReflectionRepository {
//   final CollectionReference _reflectionsCollection =
//       FirebaseFirestore.instance.collection('reflections');

//   Future<void> addReflection(Reflection reflection) async {
//     await _reflectionsCollection.add(reflection.toMap());
//   }

//   Future<void> updateReflection(Reflection reflection) async {
//     await _reflectionsCollection.doc(reflection.id).update(reflection.toMap());
//   }

//   Future<void> deleteReflection(String reflectionId) async {
//     await _reflectionsCollection.doc(reflectionId).delete();
//   }

//   Stream<List<Reflection>> getReflectionsStream() {
//     return _reflectionsCollection.snapshots().map((querySnapshot) {
//       return querySnapshot.docs.map((doc) {
//         return Reflection.fromMap(doc.data() as Map<String, dynamic>, doc.id);
//       }).toList();
//     });
//   }
// }

//------new code with db----//
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'reflection.dart';

class ReflectionRepository {
  final DatabaseReference _dbRef =
      FirebaseDatabase.instance.ref().child("users");

  /// Retrieves the currently authenticated user's ID
  String getCurrentUserId() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception("User not authenticated");
    }
    return user.uid;
  }

  /// Adds a new reflection to Firebase Realtime Database under the authenticated user's ID
  Future<void> addReflection(Reflection reflection) async {
    try {
      String userId = getCurrentUserId();
      String reflectionId = reflection.id.isNotEmpty
          ? reflection.id
          : _dbRef.child(userId).child("Reflections").push().key ??
              DateTime.now().millisecondsSinceEpoch.toString();

      await _dbRef.child(userId).child("Reflections").child(reflectionId).set(
            reflection.copyWith(id: reflectionId).toMap(),
          );
    } catch (e) {
      throw Exception("Failed to add reflection: $e");
    }
  }

  /// Updates an existing reflection in Firebase Realtime Database
  Future<void> updateReflection(Reflection reflection) async {
    try {
      String userId = getCurrentUserId();
      if (reflection.id.isEmpty) throw Exception("Invalid reflection ID");

      await _dbRef
          .child(userId)
          .child("Reflections")
          .child(reflection.id)
          .update(reflection.toMap());
    } catch (e) {
      throw Exception("Failed to update reflection: $e");
    }
  }

  /// Deletes a reflection from Firebase Realtime Database
  Future<void> deleteReflection(String reflectionId) async {
    try {
      String userId = getCurrentUserId();
      if (reflectionId.isEmpty) throw Exception("Invalid reflection ID");

      await _dbRef
          .child(userId)
          .child("Reflections")
          .child(reflectionId)
          .remove();
    } catch (e) {
      throw Exception("Failed to delete reflection: $e");
    }
  }

  /// Retrieves the list of reflections as a stream for real-time updates
  Stream<List<Reflection>> getReflectionsStream() {
    try {
      String userId = getCurrentUserId();
      return _dbRef.child(userId).child("Reflections").onValue.map((event) {
        final data = event.snapshot.value as Map<dynamic, dynamic>?;

        if (data == null) return [];

        return data.entries.map((entry) {
          final reflectionData = Map<String, dynamic>.from(entry.value);
          return Reflection.fromMap(reflectionData, entry.key);
        }).toList();
      });
    } catch (e) {
      return const Stream.empty();
    }
  }
}
