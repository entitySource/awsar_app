import '../../../core/links/mailto.dart';

/// What a donor typed. PAN lives only in this object and the email it
/// produces; nothing here is persisted.
class DonationDetails {
  const DonationDetails({
    required this.name,
    required this.email,
    required this.phone,
    required this.amount,
    required this.paymentPreference,
    this.pan,
  });

  final String name;
  final String email;
  final String phone;
  final String amount;
  final String paymentPreference;
  final String? pan;
}

class VolunteerDetails {
  const VolunteerDetails({
    required this.name,
    required this.email,
    required this.phone,
    required this.interest,
    required this.hoursPerWeek,
    required this.weeks,
    this.message,
  });

  final String name;
  final String email;
  final String phone;
  final String interest;
  final int hoursPerWeek;
  final int weeks;
  final String? message;
}

/// Email bodies stay in English so AWSAR's team can read every one,
/// whichever language the sender used in the app.
Uri donationEmail({required String to, required String subject, required DonationDetails d}) {
  final lines = [
    'Hello AWSAR team,',
    '',
    'I would like to donate from India.',
    '',
    'Name: ${d.name.trim()}',
    'Email: ${d.email.trim()}',
    'Mobile: ${d.phone.trim()}',
    'Amount: INR ${d.amount.trim()}',
    'Preferred payment method: ${d.paymentPreference}',
    if (d.pan != null && d.pan!.trim().isNotEmpty) 'PAN (for 80G receipt): ${d.pan!.trim().toUpperCase()}',
    '',
    'Please send me the payment details.',
    '',
    'Sent from the AWSAR app',
  ];
  return mailtoUri(to: to, subject: subject, body: lines.join('\n'));
}

Uri internationalDonationEmail({required String to, required String subject}) => mailtoUri(
  to: to,
  subject: subject,
  body:
      'Hello AWSAR team,\n\nI would like to donate from outside India. '
      'Please send me the FCRA account details.\n\nSent from the AWSAR app',
);

Uri volunteerEmail({required String to, required String subject, required VolunteerDetails v}) {
  final lines = [
    'Hello AWSAR team,',
    '',
    'I would like to volunteer.',
    '',
    'Name: ${v.name.trim()}',
    'Email: ${v.email.trim()}',
    'Mobile: ${v.phone.trim()}',
    'Area of interest: ${v.interest}',
    'Commitment: at least ${v.hoursPerWeek} hours a week for ${v.weeks} weeks (confirmed)',
    if (v.message != null && v.message!.trim().isNotEmpty) ...['', v.message!.trim()],
    '',
    'Sent from the AWSAR app',
  ];
  return mailtoUri(to: to, subject: subject, body: lines.join('\n'));
}
