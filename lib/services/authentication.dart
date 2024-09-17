import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance; // Initialize Firestore

  Future<User?> signUPUser(
    String email,
    String password,
    String name,
  ) async {
    try {
      final cred = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (cred.user != null) {
        // Store additional user information (e.g., name) in Firestore
        await _firestore.collection('users').doc(cred.user!.uid).set({
          'name': name,
          'email': email,
          // 'assignedRoute': assignedRoute,
          // 'password': password,
        });

        log("User signed up and data stored in Firestore.");
        return cred.user;
      }
    } catch (e) {
      log("Error during sign-up: $e");
    }
    return null;
  }

  Future<User?> logInUser(String email, String password) async {
    try {
      final cred = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return cred.user;
    } catch (e) {
      log("Something went wrong");
    }
    return null;
  }

  Future<void> signout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      log("Something went wrong");
    }
  }

  Future<void> assignRouteToDriver(String driverId, String routeId) async {
    // Update the driver's document with the assigned route ID
    await FirebaseFirestore.instance.collection('users').doc(driverId).update({
      'assignedRoute': routeId, // Reference the route by its ID
    });
  }

  Stream<User?> get authStateChanges => _auth.authStateChanges();
}
