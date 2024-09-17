import 'package:cloud_firestore/cloud_firestore.dart';

class RouteService {
  final _firestore = FirebaseFirestore.instance; // Initialize Firestore

  // Function to retrieve assigned route for a specific user
  Future<String?> getAssignedRoute(String userId) async {
    try {
      // Fetch the user's document from Firestore based on the userId
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(userId).get();
      
      if (userDoc.exists) {
        // Retrieve the assignedRoute field from the document
        return userDoc['assignedRoute'] as String?;
      } else {
        print("User not found.");
        return null;
      }
    } catch (e) {
      print("Error retrieving assigned route: $e");
      return null;
    }
  }

}
