// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'AWSAR India';

  @override
  String get navHome => 'Home';

  @override
  String get navProgrammes => 'Our work';

  @override
  String get navOpportunities => 'Students';

  @override
  String get navGetInvolved => 'Get involved';

  @override
  String get navMore => 'More';

  @override
  String get languageToggleTooltip => 'Switch language to Hindi';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageHindi => 'हिंदी';

  @override
  String get draftBadge => 'Draft translation';

  @override
  String get draftBadgeHint =>
      'This Hindi text was machine-assisted and is still being checked.';

  @override
  String sourceLabel(String host) {
    return 'Source: $host';
  }

  @override
  String get sourceOpenHint => 'Opens the original page in your browser';

  @override
  String get retry => 'Try again';

  @override
  String get errorTitle => 'Couldn\'t load this screen';

  @override
  String get errorBody =>
      'Something went wrong reading the app\'s content. Try again, and if it keeps happening, reinstall the app.';

  @override
  String get linkOpenFailed =>
      'Couldn\'t open the link. Check your connection and try again.';

  @override
  String get homeDonateCta => 'Donate';

  @override
  String get homeVolunteerCta => 'Volunteer';

  @override
  String get homeOpportunitiesCta => 'Find a scholarship';

  @override
  String get homeOurWork => 'Our work';

  @override
  String get homeSeeAll => 'See all';

  @override
  String get homeImpact => 'Our impact';

  @override
  String get homeMission => 'Our mission';

  @override
  String get homeAboutCta => 'About AWSAR';

  @override
  String get programmesTitle => 'Our work';

  @override
  String programmesSubtitle(int count) {
    return '$count programme areas';
  }

  @override
  String get programmeImpact => 'Impact';

  @override
  String get programmeAbout => 'About this programme';

  @override
  String get programmeNoDetail =>
      'More detail on this programme is coming in the next content update.';

  @override
  String get programmeSupportCta => 'Support this work';

  @override
  String get openOnWebsite => 'Open on website';

  @override
  String get opportunitiesTitle => 'Opportunities';

  @override
  String get opportunitiesSubtitle =>
      'Scholarships, mentorships and internships from EduAnchors';

  @override
  String get oppFilterAll => 'All';

  @override
  String get oppTypeScholarship => 'Scholarships';

  @override
  String get oppTypeMentorship => 'Mentorships';

  @override
  String get oppTypeInternship => 'Internships';

  @override
  String get oppSearchLabel => 'Search opportunities';

  @override
  String get oppSearchClear => 'Clear search';

  @override
  String get oppSavedOnly => 'Saved';

  @override
  String get oppSampleChip => 'Sample';

  @override
  String get oppSampleNotice =>
      'These are sample listings. Live EduAnchors listings appear after the next content update.';

  @override
  String get oppSave => 'Save';

  @override
  String get oppUnsave => 'Remove from saved';

  @override
  String get oppSavedSnack => 'Saved on this phone';

  @override
  String get oppRemovedSnack => 'Removed from saved';

  @override
  String get oppApply => 'Apply on EduAnchors';

  @override
  String get oppEligibility => 'Eligibility';

  @override
  String get oppAmount => 'Amount';

  @override
  String get oppDeadline => 'Deadline';

  @override
  String get oppLocation => 'Location';

  @override
  String get oppMode => 'Mode';

  @override
  String get oppProvider => 'Provider';

  @override
  String get oppNoResults => 'No opportunities match';

  @override
  String get oppNoResultsBody => 'Try another search or filter.';

  @override
  String get oppClearFilters => 'Clear filters';

  @override
  String get oppNoSaved => 'Nothing saved yet';

  @override
  String get oppNoSavedBody =>
      'Tap Save on an opportunity to keep it here, even offline.';

  @override
  String get getInvolvedTitle => 'Get involved';

  @override
  String get getInvolvedSubtitle => 'Give, volunteer or spread the word';

  @override
  String get donateIndiaTitle => 'Donate from India';

  @override
  String get donateIndiaSubtitle =>
      'UPI, net banking, card, bank transfer or cheque';

  @override
  String get donateIntlTitle => 'Donate from outside India';

  @override
  String get donateIntlSubtitle => 'Through AWSAR\'s FCRA account';

  @override
  String get volunteerTitle => 'Volunteer';

  @override
  String volunteerSubtitle(int hours, int weeks) {
    return '$hours hours a week for $weeks weeks';
  }

  @override
  String get fieldName => 'Full name';

  @override
  String get fieldEmail => 'Email';

  @override
  String get fieldPhone => 'Mobile number';

  @override
  String get fieldAmount => 'Amount in rupees';

  @override
  String get fieldPan => 'PAN (optional, for an 80G receipt)';

  @override
  String get fieldPanHelper =>
      'Used only in the email you send. The app never saves it.';

  @override
  String get fieldPaymentPref => 'How would you like to pay?';

  @override
  String get fieldInterest => 'Area you\'d like to help with';

  @override
  String get fieldMessage => 'Anything you\'d like AWSAR to know (optional)';

  @override
  String get fieldRequired => 'required';

  @override
  String get errRequired => 'This field is required';

  @override
  String get errEmail => 'Enter an email like name@example.com';

  @override
  String get errPhone => 'Enter a 10-digit Indian mobile number';

  @override
  String get errAmount => 'Enter an amount above ₹0';

  @override
  String get errPan => 'PAN has 10 characters, like ABCDE1234F';

  @override
  String get errFixFields => 'Fix the highlighted fields to continue';

  @override
  String get continueBtn => 'Continue';

  @override
  String get handoffTitle => 'Send your details to AWSAR';

  @override
  String get handoffBody =>
      'AWSAR\'s team replies with payment instructions. Choose how to send your details.';

  @override
  String get handoffEmail => 'Send by email';

  @override
  String get handoffEmailHint =>
      'Opens your email app with everything filled in';

  @override
  String get handoffWebsite => 'Open AWSAR website';

  @override
  String get handoffGiveDo => 'Donate on Give.do';

  @override
  String get handoffNoNetworkNote => 'Sending needs an internet connection.';

  @override
  String get successTitle => 'Your email is ready';

  @override
  String get successBody =>
      'Press Send in your email app. AWSAR usually replies within a few working days with next steps.';

  @override
  String get successDone => 'Back to Get involved';

  @override
  String get fcraContact => 'Email AWSAR for account details';

  @override
  String get fcraPayOnline => 'Pay online';

  @override
  String volunteerCommitCheck(int hours, int weeks) {
    return 'I can give at least $hours hours a week for $weeks weeks';
  }

  @override
  String get volunteerCommitRequired =>
      'Tick the commitment above to send your application';

  @override
  String get volunteerSubmit => 'Send application by email';

  @override
  String get moreTitle => 'More';

  @override
  String get aboutTitle => 'About AWSAR';

  @override
  String get aboutStory => 'Our story';

  @override
  String get aboutVision => 'Vision';

  @override
  String get aboutMission => 'Mission';

  @override
  String get aboutValues => 'What we value';

  @override
  String get eduAnchorsTitle => 'About EduAnchors';

  @override
  String get contactTitle => 'Contact';

  @override
  String get contactOffices => 'Offices';

  @override
  String get contactPhone => 'Phone';

  @override
  String get contactEmail => 'Email';

  @override
  String get contactHelplines => 'Helplines';

  @override
  String get contactEduAnchors => 'EduAnchors';

  @override
  String contactCallHint(String number) {
    return 'Call $number';
  }

  @override
  String contactEmailHint(String address) {
    return 'Email $address';
  }

  @override
  String get mediaTitle => 'Photos, videos and reports';

  @override
  String get mediaEmpty => 'Nothing here yet';

  @override
  String get mediaEmptyBody =>
      'Photos, videos and annual reports appear here after the next content update.';

  @override
  String get mediaOpenWebsite => 'See them on the website';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get settingsAbout => 'About this app';

  @override
  String get settingsAboutBody =>
      'Built for FOSS Forge 2.0. Content comes from awsarindia.org and eduanchors.com and works offline.';

  @override
  String emailSubjectDonate(String name) {
    return 'Donation from $name';
  }

  @override
  String get emailSubjectDonateIntl => 'Donation from outside India';

  @override
  String emailSubjectVolunteer(String name) {
    return 'Volunteer application from $name';
  }

  @override
  String get homeCtaTitle => 'Ready to help?';

  @override
  String get homeCtaBody =>
      'Donate, volunteer, or point a student to EduAnchors.';

  @override
  String get accountTitle => 'Account';

  @override
  String get accountSignIn => 'Sign in';

  @override
  String get accountCreate => 'Create account';

  @override
  String get accountSignedOutHint =>
      'Sign in to keep your saved opportunities on every phone and have the Donate and Volunteer forms filled in for you.';

  @override
  String get fieldPassword => 'Password';

  @override
  String get fieldPasswordHelper => 'At least 8 characters';

  @override
  String get showPassword => 'Show password';

  @override
  String get hidePassword => 'Hide password';

  @override
  String get errPassword => 'Use at least 8 characters';

  @override
  String accountSignedInAs(String email) {
    return 'Signed in as $email';
  }

  @override
  String get accountUnlocks => 'What your account does';

  @override
  String get accountUnlockSaved => 'Saved opportunities sync to your account';

  @override
  String get accountUnlockPrefill =>
      'Donate and Volunteer forms are filled in for you';

  @override
  String get accountSignOut => 'Sign out';

  @override
  String get accountSignedOutToast => 'Signed out';

  @override
  String get accountCheckEmail =>
      'Check your email to confirm your account, then sign in.';

  @override
  String get accountNotConfiguredTitle => 'Sign-in isn\'t set up in this build';

  @override
  String get accountNotConfiguredBody =>
      'Everything else works. Saved opportunities stay on this phone.';

  @override
  String get authErrInvalid => 'Email or password is wrong';

  @override
  String get authErrEmailInUse =>
      'An account with this email already exists. Sign in instead.';

  @override
  String get authErrWeak => 'Choose a stronger password';

  @override
  String get authErrNotConfirmed =>
      'Confirm your email first, using the link we sent';

  @override
  String get authErrNetwork =>
      'Couldn\'t reach the server. Check your internet and try again.';

  @override
  String get authErrUnknown => 'Something went wrong. Try again.';

  @override
  String get accountTileSignedOut => 'Sign in or create an account';

  @override
  String get prefilledNote => 'Filled in from your account';

  @override
  String get donatePayTitle => 'Scan to donate';

  @override
  String get donatePayDemo =>
      'Demo QR for the hackathon. It uses a sample UPI ID, so no money is sent.';

  @override
  String donatePayAmount(String amount, String payee) {
    return '₹$amount to $payee';
  }

  @override
  String get donatePayScanHint =>
      'Open any UPI app, such as Google Pay, PhonePe, Paytm or BHIM, and scan this code.';

  @override
  String donatePayQrLabel(String amount, String payee) {
    return 'UPI QR code to pay ₹$amount to $payee';
  }

  @override
  String get donatePayUpiId => 'UPI ID';

  @override
  String get donatePayCopy => 'Copy UPI ID';

  @override
  String get donatePayCopied => 'UPI ID copied';

  @override
  String get donatePayOpenApp => 'Pay with a UPI app on this phone';

  @override
  String get donatePayReceipt => 'Email my details for an 80G receipt';

  @override
  String get donatePayNote => 'Donation to AWSAR India';
}
