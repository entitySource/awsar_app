import 'package:awsar_app/features/get_involved/domain/handoff_builder.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const d = DonationDetails(
    name: 'Asha Verma',
    email: 'asha@example.com',
    phone: '9876543210',
    amount: '1000',
    paymentPreference: 'UPI',
    pan: 'abcde1234f',
  );

  test('donation email goes to AWSAR with %20, not +, for spaces', () {
    final uri = donationEmail(to: 'support@awsarindia.org', subject: 'Donation from Asha Verma', d: d);
    expect(uri.scheme, 'mailto');
    expect(uri.path, 'support@awsarindia.org');
    expect(uri.toString(), contains('subject=Donation%20from%20Asha%20Verma'));
    expect(uri.toString(), isNot(contains('+')));
  });

  test('PAN is upper-cased in the email and left out when empty', () {
    final withPan = Uri.decodeComponent(donationEmail(to: 'x@y.org', subject: 's', d: d).toString());
    expect(withPan, contains('PAN (for 80G receipt): ABCDE1234F'));

    const noPan = DonationDetails(
      name: 'A',
      email: 'a@b.co',
      phone: '9876543210',
      amount: '1',
      paymentPreference: 'UPI',
      pan: '',
    );
    final body = Uri.decodeComponent(donationEmail(to: 'x@y.org', subject: 's', d: noPan).toString());
    expect(body, isNot(contains('PAN')));
  });

  test('volunteer email states the confirmed commitment', () {
    final uri = volunteerEmail(
      to: 'x@y.org',
      subject: 's',
      v: const VolunteerDetails(
        name: 'A',
        email: 'a@b.co',
        phone: '9876543210',
        interest: 'Education',
        hoursPerWeek: 4,
        weeks: 8,
      ),
    );
    expect(Uri.decodeComponent(uri.toString()), contains('at least 4 hours a week for 8 weeks (confirmed)'));
  });
}
