import 'package:flutter/foundation.dart';

class ProfileProvider extends ChangeNotifier {
  String name = '';
  String email = '';
  String imageUrl = '';

  void updateProfile({
    required String name,
    required String email,
    String? imageUrl,
  }) {
    this.name = name;
    this.email = email;

    if (imageUrl != null) {
      this.imageUrl = imageUrl;
    }

    notifyListeners();
  }
}