import '../json_read.dart';
import 'labeled_value.dart';

class FcraInfo {
  const FcraInfo({required this.body, required this.details, this.paymentLinkUrl});

  final List<String> body;
  final List<LabeledValue> details;
  final String? paymentLinkUrl;

  factory FcraInfo.fromJson(Json j, String path) => FcraInfo(
    body: strList(j, 'body'),
    details: LabeledValue.listOf(j, 'details', path),
    paymentLinkUrl: optStr(j, 'paymentLinkUrl'),
  );
}

/// UPI payee for the donate QR. [demo] marks a placeholder ID that must not
/// be presented as AWSAR's real account.
class UpiInfo {
  const UpiInfo({required this.vpa, required this.payeeName, required this.demo});

  final String vpa;
  final String payeeName;
  final bool demo;

  factory UpiInfo.fromJson(Json j, String path) =>
      UpiInfo(vpa: reqStr(j, 'vpa', path), payeeName: reqStr(j, 'payeeName', path), demo: optBool(j, 'demo'));

  /// UPI deep link that any UPI app can scan or open.
  /// Spaces are sent as %20; some UPI apps show a literal '+' otherwise.
  Uri payUri({required String amount, required String note}) {
    String e(String v) => Uri.encodeComponent(v);
    return Uri.parse('upi://pay?pa=${e(vpa)}&pn=${e(payeeName)}&am=${e(amount)}&cu=INR&tn=${e(note)}');
  }
}

class DonateInfo {
  const DonateInfo({
    required this.intro,
    required this.paymentPreferences,
    required this.donatePageUrl,
    required this.fcra,
    required this.sourceUrl,
    this.taxNote,
    this.giveDoUrl,
    this.handoffEmail,
    this.upi,
  });

  final List<String> intro;
  final List<String> paymentPreferences;
  final String? taxNote;
  final String donatePageUrl;
  final String? giveDoUrl;
  final String? handoffEmail;
  final FcraInfo fcra;
  final UpiInfo? upi;
  final String sourceUrl;

  factory DonateInfo.fromJson(Json j, String path) => DonateInfo(
    intro: strList(j, 'intro'),
    paymentPreferences: strList(j, 'paymentPreferences'),
    taxNote: optStr(j, 'taxNote'),
    donatePageUrl: reqStr(j, 'donatePageUrl', path),
    giveDoUrl: optStr(j, 'giveDoUrl'),
    handoffEmail: optStr(j, 'handoffEmail'),
    fcra: FcraInfo.fromJson(reqObj(j, 'fcra', path), '$path.fcra'),
    upi: j['upi'] is Json ? UpiInfo.fromJson(j['upi'] as Json, '$path.upi') : null,
    sourceUrl: reqStr(j, 'sourceUrl', path),
  );
}

class VolunteerInfo {
  const VolunteerInfo({
    required this.intro,
    required this.minHoursPerWeek,
    required this.minWeeks,
    required this.commitmentText,
    required this.interestAreas,
    required this.sourceUrl,
    this.formUrl,
    this.handoffEmail,
  });

  final List<String> intro;
  final int minHoursPerWeek;
  final int minWeeks;
  final String commitmentText;
  final List<String> interestAreas;
  final String? formUrl;
  final String? handoffEmail;
  final String sourceUrl;

  factory VolunteerInfo.fromJson(Json j, String path) => VolunteerInfo(
    intro: strList(j, 'intro'),
    minHoursPerWeek: reqInt(j, 'minHoursPerWeek', path),
    minWeeks: reqInt(j, 'minWeeks', path),
    commitmentText: reqStr(j, 'commitmentText', path),
    interestAreas: strList(j, 'interestAreas'),
    formUrl: optStr(j, 'formUrl'),
    handoffEmail: optStr(j, 'handoffEmail'),
    sourceUrl: reqStr(j, 'sourceUrl', path),
  );
}
