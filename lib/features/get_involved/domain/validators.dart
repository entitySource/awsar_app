/// Form rules for the Donate and Volunteer screens. Each returns null when
/// the value is fine, or an error kind the screen turns into localized text.
enum FieldError { required, email, phone, amount, pan, password }

final _email = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]{2,}$');
final _pan = RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]$');

FieldError? validateRequired(String? v) => (v == null || v.trim().isEmpty) ? FieldError.required : null;

FieldError? validateEmail(String? v) {
  if (v == null || v.trim().isEmpty) return FieldError.required;
  return _email.hasMatch(v.trim()) ? null : FieldError.email;
}

/// Indian mobile: 10 digits starting 6–9, optionally prefixed +91, 91 or 0.
FieldError? validateIndianMobile(String? v) {
  if (v == null || v.trim().isEmpty) return FieldError.required;
  final digits = v.replaceAll(RegExp(r'[\s-]'), '');
  final m = RegExp(r'^(?:\+91|91|0)?([6-9][0-9]{9})$').firstMatch(digits);
  return m == null ? FieldError.phone : null;
}

FieldError? validateAmount(String? v) {
  if (v == null || v.trim().isEmpty) return FieldError.required;
  final n = num.tryParse(v.replaceAll(',', '').trim());
  return (n == null || n <= 0) ? FieldError.amount : null;
}

/// PAN is optional; when given it must look like ABCDE1234F.
FieldError? validatePanOptional(String? v) {
  if (v == null || v.trim().isEmpty) return null;
  return _pan.hasMatch(v.trim().toUpperCase()) ? null : FieldError.pan;
}

/// Account passwords: Supabase's default minimum is 6; we ask for 8.
FieldError? validatePassword(String? v) {
  if (v == null || v.isEmpty) return FieldError.required;
  return v.length < 8 ? FieldError.password : null;
}
