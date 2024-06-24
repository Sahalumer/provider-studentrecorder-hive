bool isValidEmail(String email) {
  final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  return emailRegex.hasMatch(email);
}

bool isValidPhoneNumber(String phone) {
  final RegExp phoneRegex = RegExp(r'^[0-9]{10}$');
  return phoneRegex.hasMatch(phone);
}
