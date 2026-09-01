class UserSession {
  static Map<String, dynamic>? user;

  static void saveUser(Map<String, dynamic> userData) {
    user = userData;
  }

  static void clearUser() {
    user = null;
  }
}