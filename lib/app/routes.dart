/// Route paths in one place, so screens never hard-code strings.
abstract final class Routes {
  static const home = '/';
  static const programmes = '/programmes';
  static String programme(String id) => '/programmes/$id';
  static const opportunities = '/opportunities';
  static String opportunity(String id) => '/opportunities/$id';
  static const getInvolved = '/get-involved';
  static const donateIndia = '/get-involved/donate-india';
  static const donateIntl = '/get-involved/donate-international';
  static const volunteer = '/get-involved/volunteer';
  static const handoffSent = '/get-involved/sent';
  static const more = '/more';
  static const about = '/more/about';
  static const contact = '/more/contact';
  static const media = '/more/media';
  static const account = '/more/account';
}
