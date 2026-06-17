String mapFirebaseError(String code) {
  switch (code) {
    case 'email-already-in-use':
      return 'An account with this email already exists.';
    case 'weak-password':
      return 'Password is too weak. Use at least 6 characters.';
    case 'invalid-email':
      return 'Please enter a valid email address.';
    case 'user-not-found':
      return 'No account found with this email.';
    case 'wrong-password':
      return 'Incorrect password. Please try again.';
    case 'network-request-failed':
      return 'Network error. Please check your connection.';
    case 'too-many-requests':
      return 'Too many attempts. Please try again later.';
    case 'invalid-credential':
      return 'Invalid email or password.';
    default:
      return 'Something went wrong. Please try again.';
  }
}
