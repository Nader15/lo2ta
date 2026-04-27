import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/user_entity.dart';

abstract class AuthRemoteDataSource {
  Future<UserEntity> login(String email, String password);
  Future<UserEntity> register(String email, String password, String name, UserRole role);
  Future<void> logout();
  Future<UserEntity?> getCurrentUser();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  AuthRemoteDataSourceImpl({required this.firebaseAuth, required this.firestore});

  @override
  Future<UserEntity> login(String email, String password) async {
    try {
      final userCredential = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      final doc = await firestore.collection('users').doc(userCredential.user!.uid).get();
      final data = doc.data()!;
      return UserEntity(
        id: userCredential.user!.uid,
        email: data['email'],
        name: data['name'],
        role: data['role'] == 'storeOwner' ? UserRole.storeOwner : UserRole.user,
      );
    } catch (e) { throw Exception('Login Failed: ${e.toString()}'); }
  }

  @override
  Future<UserEntity> register(String email, String password, String name, UserRole role) async {
    try {
      final userCredential = await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      final uid = userCredential.user!.uid;
      final roleStr = role == UserRole.storeOwner ? 'storeOwner' : 'user';
      await firestore.collection('users').doc(uid).set({'id': uid, 'email': email, 'name': name, 'role': roleStr, 'createdAt': FieldValue.serverTimestamp()});
      return UserEntity(id: uid, email: email, name: name, role: role);
    } catch (e) { throw Exception('Registration Failed: ${e.toString()}'); }
  }

  @override
  Future<void> logout() async { await firebaseAuth.signOut(); }

  @override
  Future<UserEntity?> getCurrentUser() async {
    final user = firebaseAuth.currentUser;
    if (user != null) {
      final doc = await firestore.collection('users').doc(user.uid).get();
      if (doc.exists) {
        final data = doc.data()!;
        return UserEntity(id: user.uid, email: data['email'], name: data['name'], role: data['role'] == 'storeOwner' ? UserRole.storeOwner : UserRole.user);
      }
    }
    return null;
  }
}
