import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_hi.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('hi'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'AWSAR India'**
  String get appTitle;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navProgrammes.
  ///
  /// In en, this message translates to:
  /// **'Our work'**
  String get navProgrammes;

  /// No description provided for @navOpportunities.
  ///
  /// In en, this message translates to:
  /// **'Students'**
  String get navOpportunities;

  /// No description provided for @navGetInvolved.
  ///
  /// In en, this message translates to:
  /// **'Get involved'**
  String get navGetInvolved;

  /// No description provided for @navMore.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get navMore;

  /// No description provided for @languageToggleTooltip.
  ///
  /// In en, this message translates to:
  /// **'Switch language to Hindi'**
  String get languageToggleTooltip;

  /// No description provided for @languageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @languageHindi.
  ///
  /// In en, this message translates to:
  /// **'हिंदी'**
  String get languageHindi;

  /// No description provided for @draftBadge.
  ///
  /// In en, this message translates to:
  /// **'Draft translation'**
  String get draftBadge;

  /// No description provided for @draftBadgeHint.
  ///
  /// In en, this message translates to:
  /// **'This Hindi text was machine-assisted and is still being checked.'**
  String get draftBadgeHint;

  /// No description provided for @sourceLabel.
  ///
  /// In en, this message translates to:
  /// **'Source: {host}'**
  String sourceLabel(String host);

  /// No description provided for @sourceOpenHint.
  ///
  /// In en, this message translates to:
  /// **'Opens the original page in your browser'**
  String get sourceOpenHint;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get retry;

  /// No description provided for @errorTitle.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t load this screen'**
  String get errorTitle;

  /// No description provided for @errorBody.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong reading the app\'s content. Try again, and if it keeps happening, reinstall the app.'**
  String get errorBody;

  /// No description provided for @linkOpenFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t open the link. Check your connection and try again.'**
  String get linkOpenFailed;

  /// No description provided for @homeDonateCta.
  ///
  /// In en, this message translates to:
  /// **'Donate'**
  String get homeDonateCta;

  /// No description provided for @homeVolunteerCta.
  ///
  /// In en, this message translates to:
  /// **'Volunteer'**
  String get homeVolunteerCta;

  /// No description provided for @homeOpportunitiesCta.
  ///
  /// In en, this message translates to:
  /// **'Find a scholarship'**
  String get homeOpportunitiesCta;

  /// No description provided for @homeOurWork.
  ///
  /// In en, this message translates to:
  /// **'Our work'**
  String get homeOurWork;

  /// No description provided for @homeSeeAll.
  ///
  /// In en, this message translates to:
  /// **'See all'**
  String get homeSeeAll;

  /// No description provided for @homeImpact.
  ///
  /// In en, this message translates to:
  /// **'Our impact'**
  String get homeImpact;

  /// No description provided for @homeMission.
  ///
  /// In en, this message translates to:
  /// **'Our mission'**
  String get homeMission;

  /// No description provided for @homeAboutCta.
  ///
  /// In en, this message translates to:
  /// **'About AWSAR'**
  String get homeAboutCta;

  /// No description provided for @programmesTitle.
  ///
  /// In en, this message translates to:
  /// **'Our work'**
  String get programmesTitle;

  /// No description provided for @programmesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'{count} programme areas'**
  String programmesSubtitle(int count);

  /// No description provided for @programmeImpact.
  ///
  /// In en, this message translates to:
  /// **'Impact'**
  String get programmeImpact;

  /// No description provided for @programmeAbout.
  ///
  /// In en, this message translates to:
  /// **'About this programme'**
  String get programmeAbout;

  /// No description provided for @programmeNoDetail.
  ///
  /// In en, this message translates to:
  /// **'More detail on this programme is coming in the next content update.'**
  String get programmeNoDetail;

  /// No description provided for @programmeSupportCta.
  ///
  /// In en, this message translates to:
  /// **'Support this work'**
  String get programmeSupportCta;

  /// No description provided for @openOnWebsite.
  ///
  /// In en, this message translates to:
  /// **'Open on website'**
  String get openOnWebsite;

  /// No description provided for @opportunitiesTitle.
  ///
  /// In en, this message translates to:
  /// **'Opportunities'**
  String get opportunitiesTitle;

  /// No description provided for @opportunitiesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Scholarships, mentorships and internships from EduAnchors'**
  String get opportunitiesSubtitle;

  /// No description provided for @oppFilterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get oppFilterAll;

  /// No description provided for @oppTypeScholarship.
  ///
  /// In en, this message translates to:
  /// **'Scholarships'**
  String get oppTypeScholarship;

  /// No description provided for @oppTypeMentorship.
  ///
  /// In en, this message translates to:
  /// **'Mentorships'**
  String get oppTypeMentorship;

  /// No description provided for @oppTypeInternship.
  ///
  /// In en, this message translates to:
  /// **'Internships'**
  String get oppTypeInternship;

  /// No description provided for @oppSearchLabel.
  ///
  /// In en, this message translates to:
  /// **'Search opportunities'**
  String get oppSearchLabel;

  /// No description provided for @oppSearchClear.
  ///
  /// In en, this message translates to:
  /// **'Clear search'**
  String get oppSearchClear;

  /// No description provided for @oppSavedOnly.
  ///
  /// In en, this message translates to:
  /// **'Saved'**
  String get oppSavedOnly;

  /// No description provided for @oppSampleChip.
  ///
  /// In en, this message translates to:
  /// **'Sample'**
  String get oppSampleChip;

  /// No description provided for @oppSampleNotice.
  ///
  /// In en, this message translates to:
  /// **'These are sample listings. Live EduAnchors listings appear after the next content update.'**
  String get oppSampleNotice;

  /// No description provided for @oppSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get oppSave;

  /// No description provided for @oppUnsave.
  ///
  /// In en, this message translates to:
  /// **'Remove from saved'**
  String get oppUnsave;

  /// No description provided for @oppSavedSnack.
  ///
  /// In en, this message translates to:
  /// **'Saved on this phone'**
  String get oppSavedSnack;

  /// No description provided for @oppRemovedSnack.
  ///
  /// In en, this message translates to:
  /// **'Removed from saved'**
  String get oppRemovedSnack;

  /// No description provided for @oppApply.
  ///
  /// In en, this message translates to:
  /// **'Apply on EduAnchors'**
  String get oppApply;

  /// No description provided for @oppEligibility.
  ///
  /// In en, this message translates to:
  /// **'Eligibility'**
  String get oppEligibility;

  /// No description provided for @oppAmount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get oppAmount;

  /// No description provided for @oppDeadline.
  ///
  /// In en, this message translates to:
  /// **'Deadline'**
  String get oppDeadline;

  /// No description provided for @oppLocation.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get oppLocation;

  /// No description provided for @oppMode.
  ///
  /// In en, this message translates to:
  /// **'Mode'**
  String get oppMode;

  /// No description provided for @oppProvider.
  ///
  /// In en, this message translates to:
  /// **'Provider'**
  String get oppProvider;

  /// No description provided for @oppNoResults.
  ///
  /// In en, this message translates to:
  /// **'No opportunities match'**
  String get oppNoResults;

  /// No description provided for @oppNoResultsBody.
  ///
  /// In en, this message translates to:
  /// **'Try another search or filter.'**
  String get oppNoResultsBody;

  /// No description provided for @oppClearFilters.
  ///
  /// In en, this message translates to:
  /// **'Clear filters'**
  String get oppClearFilters;

  /// No description provided for @oppNoSaved.
  ///
  /// In en, this message translates to:
  /// **'Nothing saved yet'**
  String get oppNoSaved;

  /// No description provided for @oppNoSavedBody.
  ///
  /// In en, this message translates to:
  /// **'Tap Save on an opportunity to keep it here, even offline.'**
  String get oppNoSavedBody;

  /// No description provided for @getInvolvedTitle.
  ///
  /// In en, this message translates to:
  /// **'Get involved'**
  String get getInvolvedTitle;

  /// No description provided for @getInvolvedSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Give, volunteer or spread the word'**
  String get getInvolvedSubtitle;

  /// No description provided for @donateIndiaTitle.
  ///
  /// In en, this message translates to:
  /// **'Donate from India'**
  String get donateIndiaTitle;

  /// No description provided for @donateIndiaSubtitle.
  ///
  /// In en, this message translates to:
  /// **'UPI, net banking, card, bank transfer or cheque'**
  String get donateIndiaSubtitle;

  /// No description provided for @donateIntlTitle.
  ///
  /// In en, this message translates to:
  /// **'Donate from outside India'**
  String get donateIntlTitle;

  /// No description provided for @donateIntlSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Through AWSAR\'s FCRA account'**
  String get donateIntlSubtitle;

  /// No description provided for @volunteerTitle.
  ///
  /// In en, this message translates to:
  /// **'Volunteer'**
  String get volunteerTitle;

  /// No description provided for @volunteerSubtitle.
  ///
  /// In en, this message translates to:
  /// **'{hours} hours a week for {weeks} weeks'**
  String volunteerSubtitle(int hours, int weeks);

  /// No description provided for @fieldName.
  ///
  /// In en, this message translates to:
  /// **'Full name'**
  String get fieldName;

  /// No description provided for @fieldEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get fieldEmail;

  /// No description provided for @fieldPhone.
  ///
  /// In en, this message translates to:
  /// **'Mobile number'**
  String get fieldPhone;

  /// No description provided for @fieldAmount.
  ///
  /// In en, this message translates to:
  /// **'Amount in rupees'**
  String get fieldAmount;

  /// No description provided for @fieldPan.
  ///
  /// In en, this message translates to:
  /// **'PAN (optional, for an 80G receipt)'**
  String get fieldPan;

  /// No description provided for @fieldPanHelper.
  ///
  /// In en, this message translates to:
  /// **'Used only in the email you send. The app never saves it.'**
  String get fieldPanHelper;

  /// No description provided for @fieldPaymentPref.
  ///
  /// In en, this message translates to:
  /// **'How would you like to pay?'**
  String get fieldPaymentPref;

  /// No description provided for @fieldInterest.
  ///
  /// In en, this message translates to:
  /// **'Area you\'d like to help with'**
  String get fieldInterest;

  /// No description provided for @fieldMessage.
  ///
  /// In en, this message translates to:
  /// **'Anything you\'d like AWSAR to know (optional)'**
  String get fieldMessage;

  /// No description provided for @fieldRequired.
  ///
  /// In en, this message translates to:
  /// **'required'**
  String get fieldRequired;

  /// No description provided for @errRequired.
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get errRequired;

  /// No description provided for @errEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter an email like name@example.com'**
  String get errEmail;

  /// No description provided for @errPhone.
  ///
  /// In en, this message translates to:
  /// **'Enter a 10-digit Indian mobile number'**
  String get errPhone;

  /// No description provided for @errAmount.
  ///
  /// In en, this message translates to:
  /// **'Enter an amount above ₹0'**
  String get errAmount;

  /// No description provided for @errPan.
  ///
  /// In en, this message translates to:
  /// **'PAN has 10 characters, like ABCDE1234F'**
  String get errPan;

  /// No description provided for @errFixFields.
  ///
  /// In en, this message translates to:
  /// **'Fix the highlighted fields to continue'**
  String get errFixFields;

  /// No description provided for @continueBtn.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueBtn;

  /// No description provided for @handoffTitle.
  ///
  /// In en, this message translates to:
  /// **'Send your details to AWSAR'**
  String get handoffTitle;

  /// No description provided for @handoffBody.
  ///
  /// In en, this message translates to:
  /// **'AWSAR\'s team replies with payment instructions. Choose how to send your details.'**
  String get handoffBody;

  /// No description provided for @handoffEmail.
  ///
  /// In en, this message translates to:
  /// **'Send by email'**
  String get handoffEmail;

  /// No description provided for @handoffEmailHint.
  ///
  /// In en, this message translates to:
  /// **'Opens your email app with everything filled in'**
  String get handoffEmailHint;

  /// No description provided for @handoffWebsite.
  ///
  /// In en, this message translates to:
  /// **'Open AWSAR website'**
  String get handoffWebsite;

  /// No description provided for @handoffGiveDo.
  ///
  /// In en, this message translates to:
  /// **'Donate on Give.do'**
  String get handoffGiveDo;

  /// No description provided for @handoffNoNetworkNote.
  ///
  /// In en, this message translates to:
  /// **'Sending needs an internet connection.'**
  String get handoffNoNetworkNote;

  /// No description provided for @successTitle.
  ///
  /// In en, this message translates to:
  /// **'Your email is ready'**
  String get successTitle;

  /// No description provided for @successBody.
  ///
  /// In en, this message translates to:
  /// **'Press Send in your email app. AWSAR usually replies within a few working days with next steps.'**
  String get successBody;

  /// No description provided for @successDone.
  ///
  /// In en, this message translates to:
  /// **'Back to Get involved'**
  String get successDone;

  /// No description provided for @fcraContact.
  ///
  /// In en, this message translates to:
  /// **'Email AWSAR for account details'**
  String get fcraContact;

  /// No description provided for @fcraPayOnline.
  ///
  /// In en, this message translates to:
  /// **'Pay online'**
  String get fcraPayOnline;

  /// No description provided for @volunteerCommitCheck.
  ///
  /// In en, this message translates to:
  /// **'I can give at least {hours} hours a week for {weeks} weeks'**
  String volunteerCommitCheck(int hours, int weeks);

  /// No description provided for @volunteerCommitRequired.
  ///
  /// In en, this message translates to:
  /// **'Tick the commitment above to send your application'**
  String get volunteerCommitRequired;

  /// No description provided for @volunteerSubmit.
  ///
  /// In en, this message translates to:
  /// **'Send application by email'**
  String get volunteerSubmit;

  /// No description provided for @moreTitle.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get moreTitle;

  /// No description provided for @aboutTitle.
  ///
  /// In en, this message translates to:
  /// **'About AWSAR'**
  String get aboutTitle;

  /// No description provided for @aboutStory.
  ///
  /// In en, this message translates to:
  /// **'Our story'**
  String get aboutStory;

  /// No description provided for @aboutVision.
  ///
  /// In en, this message translates to:
  /// **'Vision'**
  String get aboutVision;

  /// No description provided for @aboutMission.
  ///
  /// In en, this message translates to:
  /// **'Mission'**
  String get aboutMission;

  /// No description provided for @aboutValues.
  ///
  /// In en, this message translates to:
  /// **'What we value'**
  String get aboutValues;

  /// No description provided for @eduAnchorsTitle.
  ///
  /// In en, this message translates to:
  /// **'About EduAnchors'**
  String get eduAnchorsTitle;

  /// No description provided for @contactTitle.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get contactTitle;

  /// No description provided for @contactOffices.
  ///
  /// In en, this message translates to:
  /// **'Offices'**
  String get contactOffices;

  /// No description provided for @contactPhone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get contactPhone;

  /// No description provided for @contactEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get contactEmail;

  /// No description provided for @contactHelplines.
  ///
  /// In en, this message translates to:
  /// **'Helplines'**
  String get contactHelplines;

  /// No description provided for @contactEduAnchors.
  ///
  /// In en, this message translates to:
  /// **'EduAnchors'**
  String get contactEduAnchors;

  /// No description provided for @contactCallHint.
  ///
  /// In en, this message translates to:
  /// **'Call {number}'**
  String contactCallHint(String number);

  /// No description provided for @contactEmailHint.
  ///
  /// In en, this message translates to:
  /// **'Email {address}'**
  String contactEmailHint(String address);

  /// No description provided for @mediaTitle.
  ///
  /// In en, this message translates to:
  /// **'Photos, videos and reports'**
  String get mediaTitle;

  /// No description provided for @mediaEmpty.
  ///
  /// In en, this message translates to:
  /// **'Nothing here yet'**
  String get mediaEmpty;

  /// No description provided for @mediaEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'Photos, videos and annual reports appear here after the next content update.'**
  String get mediaEmptyBody;

  /// No description provided for @mediaOpenWebsite.
  ///
  /// In en, this message translates to:
  /// **'See them on the website'**
  String get mediaOpenWebsite;

  /// No description provided for @settingsLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsLanguage;

  /// No description provided for @settingsAbout.
  ///
  /// In en, this message translates to:
  /// **'About this app'**
  String get settingsAbout;

  /// No description provided for @settingsAboutBody.
  ///
  /// In en, this message translates to:
  /// **'Built for FOSS Forge 2.0. Content comes from awsarindia.org and eduanchors.com and works offline.'**
  String get settingsAboutBody;

  /// No description provided for @emailSubjectDonate.
  ///
  /// In en, this message translates to:
  /// **'Donation from {name}'**
  String emailSubjectDonate(String name);

  /// No description provided for @emailSubjectDonateIntl.
  ///
  /// In en, this message translates to:
  /// **'Donation from outside India'**
  String get emailSubjectDonateIntl;

  /// No description provided for @emailSubjectVolunteer.
  ///
  /// In en, this message translates to:
  /// **'Volunteer application from {name}'**
  String emailSubjectVolunteer(String name);

  /// No description provided for @homeCtaTitle.
  ///
  /// In en, this message translates to:
  /// **'Ready to help?'**
  String get homeCtaTitle;

  /// No description provided for @homeCtaBody.
  ///
  /// In en, this message translates to:
  /// **'Donate, volunteer, or point a student to EduAnchors.'**
  String get homeCtaBody;

  /// No description provided for @accountTitle.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get accountTitle;

  /// No description provided for @accountSignIn.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get accountSignIn;

  /// No description provided for @accountCreate.
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get accountCreate;

  /// No description provided for @accountSignedOutHint.
  ///
  /// In en, this message translates to:
  /// **'Sign in to keep your saved opportunities on every phone and have the Donate and Volunteer forms filled in for you.'**
  String get accountSignedOutHint;

  /// No description provided for @fieldPassword.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get fieldPassword;

  /// No description provided for @fieldPasswordHelper.
  ///
  /// In en, this message translates to:
  /// **'At least 8 characters'**
  String get fieldPasswordHelper;

  /// No description provided for @showPassword.
  ///
  /// In en, this message translates to:
  /// **'Show password'**
  String get showPassword;

  /// No description provided for @hidePassword.
  ///
  /// In en, this message translates to:
  /// **'Hide password'**
  String get hidePassword;

  /// No description provided for @errPassword.
  ///
  /// In en, this message translates to:
  /// **'Use at least 8 characters'**
  String get errPassword;

  /// No description provided for @accountSignedInAs.
  ///
  /// In en, this message translates to:
  /// **'Signed in as {email}'**
  String accountSignedInAs(String email);

  /// No description provided for @accountUnlocks.
  ///
  /// In en, this message translates to:
  /// **'What your account does'**
  String get accountUnlocks;

  /// No description provided for @accountUnlockSaved.
  ///
  /// In en, this message translates to:
  /// **'Saved opportunities sync to your account'**
  String get accountUnlockSaved;

  /// No description provided for @accountUnlockPrefill.
  ///
  /// In en, this message translates to:
  /// **'Donate and Volunteer forms are filled in for you'**
  String get accountUnlockPrefill;

  /// No description provided for @accountSignOut.
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get accountSignOut;

  /// No description provided for @accountSignedOutToast.
  ///
  /// In en, this message translates to:
  /// **'Signed out'**
  String get accountSignedOutToast;

  /// No description provided for @accountCheckEmail.
  ///
  /// In en, this message translates to:
  /// **'Check your email to confirm your account, then sign in.'**
  String get accountCheckEmail;

  /// No description provided for @accountNotConfiguredTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign-in isn\'t set up in this build'**
  String get accountNotConfiguredTitle;

  /// No description provided for @accountNotConfiguredBody.
  ///
  /// In en, this message translates to:
  /// **'Everything else works. Saved opportunities stay on this phone.'**
  String get accountNotConfiguredBody;

  /// No description provided for @authErrInvalid.
  ///
  /// In en, this message translates to:
  /// **'Email or password is wrong'**
  String get authErrInvalid;

  /// No description provided for @authErrEmailInUse.
  ///
  /// In en, this message translates to:
  /// **'An account with this email already exists. Sign in instead.'**
  String get authErrEmailInUse;

  /// No description provided for @authErrWeak.
  ///
  /// In en, this message translates to:
  /// **'Choose a stronger password'**
  String get authErrWeak;

  /// No description provided for @authErrNotConfirmed.
  ///
  /// In en, this message translates to:
  /// **'Confirm your email first, using the link we sent'**
  String get authErrNotConfirmed;

  /// No description provided for @authErrNetwork.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t reach the server. Check your internet and try again.'**
  String get authErrNetwork;

  /// No description provided for @authErrUnknown.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Try again.'**
  String get authErrUnknown;

  /// No description provided for @accountTileSignedOut.
  ///
  /// In en, this message translates to:
  /// **'Sign in or create an account'**
  String get accountTileSignedOut;

  /// No description provided for @prefilledNote.
  ///
  /// In en, this message translates to:
  /// **'Filled in from your account'**
  String get prefilledNote;

  /// No description provided for @donatePayTitle.
  ///
  /// In en, this message translates to:
  /// **'Scan to donate'**
  String get donatePayTitle;

  /// No description provided for @donatePayDemo.
  ///
  /// In en, this message translates to:
  /// **'Demo QR for the hackathon. It uses a sample UPI ID, so no money is sent.'**
  String get donatePayDemo;

  /// No description provided for @donatePayAmount.
  ///
  /// In en, this message translates to:
  /// **'₹{amount} to {payee}'**
  String donatePayAmount(String amount, String payee);

  /// No description provided for @donatePayScanHint.
  ///
  /// In en, this message translates to:
  /// **'Open any UPI app, such as Google Pay, PhonePe, Paytm or BHIM, and scan this code.'**
  String get donatePayScanHint;

  /// No description provided for @donatePayQrLabel.
  ///
  /// In en, this message translates to:
  /// **'UPI QR code to pay ₹{amount} to {payee}'**
  String donatePayQrLabel(String amount, String payee);

  /// No description provided for @donatePayUpiId.
  ///
  /// In en, this message translates to:
  /// **'UPI ID'**
  String get donatePayUpiId;

  /// No description provided for @donatePayCopy.
  ///
  /// In en, this message translates to:
  /// **'Copy UPI ID'**
  String get donatePayCopy;

  /// No description provided for @donatePayCopied.
  ///
  /// In en, this message translates to:
  /// **'UPI ID copied'**
  String get donatePayCopied;

  /// No description provided for @donatePayOpenApp.
  ///
  /// In en, this message translates to:
  /// **'Pay with a UPI app on this phone'**
  String get donatePayOpenApp;

  /// No description provided for @donatePayReceipt.
  ///
  /// In en, this message translates to:
  /// **'Email my details for an 80G receipt'**
  String get donatePayReceipt;

  /// No description provided for @donatePayNote.
  ///
  /// In en, this message translates to:
  /// **'Donation to AWSAR India'**
  String get donatePayNote;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'hi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'hi':
      return AppLocalizationsHi();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
