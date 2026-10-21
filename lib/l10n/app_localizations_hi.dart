// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get appTitle => 'अवसर इंडिया';

  @override
  String get navHome => 'होम';

  @override
  String get navProgrammes => 'हमारा काम';

  @override
  String get navOpportunities => 'छात्र';

  @override
  String get navGetInvolved => 'जुड़ें';

  @override
  String get navMore => 'और';

  @override
  String get languageToggleTooltip => 'भाषा अंग्रेज़ी में बदलें';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageHindi => 'हिंदी';

  @override
  String get draftBadge => 'ड्राफ़्ट अनुवाद';

  @override
  String get draftBadgeHint =>
      'यह हिंदी पाठ मशीन की मदद से बना है और अभी जाँचा जा रहा है।';

  @override
  String sourceLabel(String host) {
    return 'स्रोत: $host';
  }

  @override
  String get sourceOpenHint => 'मूल पेज आपके ब्राउज़र में खुलेगा';

  @override
  String get retry => 'फिर से कोशिश करें';

  @override
  String get errorTitle => 'यह स्क्रीन लोड नहीं हो सकी';

  @override
  String get errorBody =>
      'ऐप की सामग्री पढ़ने में दिक्कत हुई। फिर से कोशिश करें, और बार-बार हो तो ऐप दोबारा इंस्टॉल करें।';

  @override
  String get linkOpenFailed =>
      'लिंक नहीं खुल सका। इंटरनेट जाँचकर फिर से कोशिश करें।';

  @override
  String get homeDonateCta => 'दान करें';

  @override
  String get homeVolunteerCta => 'स्वयंसेवक बनें';

  @override
  String get homeOpportunitiesCta => 'स्कॉलरशिप खोजें';

  @override
  String get homeOurWork => 'हमारा काम';

  @override
  String get homeSeeAll => 'सभी देखें';

  @override
  String get homeImpact => 'हमारा प्रभाव';

  @override
  String get homeMission => 'हमारा मिशन';

  @override
  String get homeAboutCta => 'अवसर के बारे में';

  @override
  String get programmesTitle => 'हमारा काम';

  @override
  String programmesSubtitle(int count) {
    return '$count कार्यक्षेत्र';
  }

  @override
  String get programmeImpact => 'प्रभाव';

  @override
  String get programmeAbout => 'इस कार्यक्रम के बारे में';

  @override
  String get programmeNoDetail =>
      'इस कार्यक्रम की और जानकारी अगले कंटेंट अपडेट में आएगी।';

  @override
  String get programmeSupportCta => 'इस काम में मदद करें';

  @override
  String get openOnWebsite => 'वेबसाइट पर खोलें';

  @override
  String get opportunitiesTitle => 'अवसर';

  @override
  String get opportunitiesSubtitle =>
      'एजुएंकर्स से स्कॉलरशिप, मेंटरशिप और इंटर्नशिप';

  @override
  String get oppFilterAll => 'सभी';

  @override
  String get oppTypeScholarship => 'स्कॉलरशिप';

  @override
  String get oppTypeMentorship => 'मेंटरशिप';

  @override
  String get oppTypeInternship => 'इंटर्नशिप';

  @override
  String get oppSearchLabel => 'अवसर खोजें';

  @override
  String get oppSearchClear => 'खोज साफ़ करें';

  @override
  String get oppSavedOnly => 'सेव किए गए';

  @override
  String get oppSampleChip => 'नमूना';

  @override
  String get oppSampleNotice =>
      'ये नमूना सूचियाँ हैं। एजुएंकर्स की असली सूचियाँ अगले कंटेंट अपडेट के बाद दिखेंगी।';

  @override
  String get oppSave => 'सेव करें';

  @override
  String get oppUnsave => 'सेव से हटाएँ';

  @override
  String get oppSavedSnack => 'इस फ़ोन पर सेव हो गया';

  @override
  String get oppRemovedSnack => 'सेव से हटा दिया';

  @override
  String get oppApply => 'एजुएंकर्स पर आवेदन करें';

  @override
  String get oppEligibility => 'पात्रता';

  @override
  String get oppAmount => 'राशि';

  @override
  String get oppDeadline => 'अंतिम तिथि';

  @override
  String get oppLocation => 'स्थान';

  @override
  String get oppMode => 'माध्यम';

  @override
  String get oppProvider => 'प्रदाता';

  @override
  String get oppNoResults => 'कोई अवसर नहीं मिला';

  @override
  String get oppNoResultsBody => 'कोई दूसरी खोज या फ़िल्टर आज़माएँ।';

  @override
  String get oppClearFilters => 'फ़िल्टर हटाएँ';

  @override
  String get oppNoSaved => 'अभी कुछ सेव नहीं है';

  @override
  String get oppNoSavedBody =>
      'किसी अवसर पर सेव करें दबाएँ, वह यहाँ ऑफ़लाइन भी दिखेगा।';

  @override
  String get getInvolvedTitle => 'जुड़ें';

  @override
  String get getInvolvedSubtitle => 'दान करें, स्वयंसेवक बनें या बात फैलाएँ';

  @override
  String get donateIndiaTitle => 'भारत से दान करें';

  @override
  String get donateIndiaSubtitle =>
      'यूपीआई, नेट बैंकिंग, कार्ड, बैंक ट्रांसफ़र या चेक';

  @override
  String get donateIntlTitle => 'भारत के बाहर से दान करें';

  @override
  String get donateIntlSubtitle => 'अवसर के एफ़सीआरए खाते के ज़रिए';

  @override
  String get volunteerTitle => 'स्वयंसेवक बनें';

  @override
  String volunteerSubtitle(int hours, int weeks) {
    return '$weeks हफ़्तों तक हर हफ़्ते $hours घंटे';
  }

  @override
  String get fieldName => 'पूरा नाम';

  @override
  String get fieldEmail => 'ईमेल';

  @override
  String get fieldPhone => 'मोबाइल नंबर';

  @override
  String get fieldAmount => 'राशि (रुपये में)';

  @override
  String get fieldPan => 'पैन (वैकल्पिक, 80G रसीद के लिए)';

  @override
  String get fieldPanHelper =>
      'सिर्फ़ आपके भेजे ईमेल में जाता है। ऐप इसे कभी सेव नहीं करता।';

  @override
  String get fieldPaymentPref => 'आप कैसे भुगतान करना चाहेंगे?';

  @override
  String get fieldInterest => 'आप किस क्षेत्र में मदद करना चाहेंगे';

  @override
  String get fieldMessage => 'अवसर को कुछ बताना चाहें (वैकल्पिक)';

  @override
  String get fieldRequired => 'ज़रूरी';

  @override
  String get errRequired => 'यह जानकारी ज़रूरी है';

  @override
  String get errEmail => 'name@example.com जैसा ईमेल लिखें';

  @override
  String get errPhone => '10 अंकों का भारतीय मोबाइल नंबर लिखें';

  @override
  String get errAmount => '₹0 से ज़्यादा राशि लिखें';

  @override
  String get errPan => 'पैन में 10 अक्षर होते हैं, जैसे ABCDE1234F';

  @override
  String get errFixFields => 'आगे बढ़ने के लिए चिह्नित जानकारी ठीक करें';

  @override
  String get continueBtn => 'आगे बढ़ें';

  @override
  String get handoffTitle => 'अपनी जानकारी अवसर को भेजें';

  @override
  String get handoffBody =>
      'अवसर की टीम भुगतान का तरीका बताकर जवाब देगी। जानकारी भेजने का तरीका चुनें।';

  @override
  String get handoffEmail => 'ईमेल से भेजें';

  @override
  String get handoffEmailHint => 'आपका ईमेल ऐप सारी जानकारी भरकर खुलेगा';

  @override
  String get handoffWebsite => 'अवसर की वेबसाइट खोलें';

  @override
  String get handoffGiveDo => 'Give.do पर दान करें';

  @override
  String get handoffNoNetworkNote => 'भेजने के लिए इंटरनेट चाहिए।';

  @override
  String get successTitle => 'आपका ईमेल तैयार है';

  @override
  String get successBody =>
      'अपने ईमेल ऐप में भेजें दबाएँ। अवसर आमतौर पर कुछ कामकाजी दिनों में अगले कदम बताता है।';

  @override
  String get successDone => 'जुड़ें पर वापस जाएँ';

  @override
  String get fcraContact => 'खाते की जानकारी के लिए अवसर को ईमेल करें';

  @override
  String get fcraPayOnline => 'ऑनलाइन भुगतान करें';

  @override
  String volunteerCommitCheck(int hours, int weeks) {
    return 'मैं $weeks हफ़्तों तक हर हफ़्ते कम से कम $hours घंटे दे सकता/सकती हूँ';
  }

  @override
  String get volunteerCommitRequired =>
      'आवेदन भेजने के लिए ऊपर की प्रतिबद्धता पर टिक करें';

  @override
  String get volunteerSubmit => 'आवेदन ईमेल से भेजें';

  @override
  String get moreTitle => 'और';

  @override
  String get aboutTitle => 'अवसर के बारे में';

  @override
  String get aboutStory => 'हमारी कहानी';

  @override
  String get aboutVision => 'दृष्टि';

  @override
  String get aboutMission => 'मिशन';

  @override
  String get aboutValues => 'हमारे मूल्य';

  @override
  String get eduAnchorsTitle => 'एजुएंकर्स के बारे में';

  @override
  String get contactTitle => 'संपर्क';

  @override
  String get contactOffices => 'कार्यालय';

  @override
  String get contactPhone => 'फ़ोन';

  @override
  String get contactEmail => 'ईमेल';

  @override
  String get contactHelplines => 'हेल्पलाइन';

  @override
  String get contactEduAnchors => 'एजुएंकर्स';

  @override
  String contactCallHint(String number) {
    return '$number पर कॉल करें';
  }

  @override
  String contactEmailHint(String address) {
    return '$address पर ईमेल करें';
  }

  @override
  String get mediaTitle => 'फ़ोटो, वीडियो और रिपोर्ट';

  @override
  String get mediaEmpty => 'अभी यहाँ कुछ नहीं है';

  @override
  String get mediaEmptyBody =>
      'फ़ोटो, वीडियो और वार्षिक रिपोर्ट अगले कंटेंट अपडेट के बाद यहाँ दिखेंगी।';

  @override
  String get mediaOpenWebsite => 'इन्हें वेबसाइट पर देखें';

  @override
  String get settingsLanguage => 'भाषा';

  @override
  String get settingsAbout => 'इस ऐप के बारे में';

  @override
  String get settingsAboutBody =>
      'FOSS Forge 2.0 के लिए बनाया गया। सामग्री awsarindia.org और eduanchors.com से है और ऑफ़लाइन चलती है।';

  @override
  String emailSubjectDonate(String name) {
    return '$name की ओर से दान';
  }

  @override
  String get emailSubjectDonateIntl => 'भारत के बाहर से दान';

  @override
  String emailSubjectVolunteer(String name) {
    return '$name का स्वयंसेवक आवेदन';
  }

  @override
  String get homeCtaTitle => 'मदद के लिए तैयार?';

  @override
  String get homeCtaBody =>
      'दान करें, स्वयंसेवक बनें, या किसी छात्र को एजुएंकर्स तक पहुँचाएँ।';

  @override
  String get accountTitle => 'खाता';

  @override
  String get accountSignIn => 'साइन इन करें';

  @override
  String get accountCreate => 'खाता बनाएँ';

  @override
  String get accountSignedOutHint =>
      'साइन इन करें ताकि आपके सेव किए गए अवसर हर फ़ोन पर रहें और दान व स्वयंसेवा फ़ॉर्म अपने आप भर जाएँ।';

  @override
  String get fieldPassword => 'पासवर्ड';

  @override
  String get fieldPasswordHelper => 'कम से कम 8 अक्षर';

  @override
  String get showPassword => 'पासवर्ड दिखाएँ';

  @override
  String get hidePassword => 'पासवर्ड छिपाएँ';

  @override
  String get errPassword => 'कम से कम 8 अक्षर रखें';

  @override
  String accountSignedInAs(String email) {
    return '$email के रूप में साइन इन';
  }

  @override
  String get accountUnlocks => 'आपका खाता क्या करता है';

  @override
  String get accountUnlockSaved =>
      'सेव किए गए अवसर आपके खाते में सिंक होते हैं';

  @override
  String get accountUnlockPrefill =>
      'दान और स्वयंसेवा फ़ॉर्म अपने आप भर जाते हैं';

  @override
  String get accountSignOut => 'साइन आउट करें';

  @override
  String get accountSignedOutToast => 'साइन आउट हो गया';

  @override
  String get accountCheckEmail =>
      'अपना खाता पक्का करने के लिए ईमेल देखें, फिर साइन इन करें।';

  @override
  String get accountNotConfiguredTitle => 'इस बिल्ड में साइन-इन चालू नहीं है';

  @override
  String get accountNotConfiguredBody =>
      'बाकी सब काम करता है। सेव किए गए अवसर इसी फ़ोन पर रहते हैं।';

  @override
  String get authErrInvalid => 'ईमेल या पासवर्ड गलत है';

  @override
  String get authErrEmailInUse => 'इस ईमेल से खाता पहले से है। साइन इन करें।';

  @override
  String get authErrWeak => 'ज़्यादा मज़बूत पासवर्ड चुनें';

  @override
  String get authErrNotConfirmed => 'पहले भेजे गए लिंक से अपना ईमेल पक्का करें';

  @override
  String get authErrNetwork =>
      'सर्वर तक नहीं पहुँच सके। इंटरनेट देखें और फिर कोशिश करें।';

  @override
  String get authErrUnknown => 'कुछ गलत हुआ। फिर कोशिश करें।';

  @override
  String get accountTileSignedOut => 'साइन इन करें या खाता बनाएँ';

  @override
  String get prefilledNote => 'आपके खाते से भरा गया';

  @override
  String get donatePayTitle => 'स्कैन करके दान करें';

  @override
  String get donatePayDemo =>
      'हैकाथॉन के लिए डेमो QR। इसमें नमूना UPI ID है, इसलिए कोई पैसा नहीं जाता।';

  @override
  String donatePayAmount(String amount, String payee) {
    return '$payee को ₹$amount';
  }

  @override
  String get donatePayScanHint =>
      'Google Pay, PhonePe, Paytm या BHIM जैसा कोई भी UPI ऐप खोलें और यह कोड स्कैन करें।';

  @override
  String donatePayQrLabel(String amount, String payee) {
    return '$payee को ₹$amount भेजने का UPI QR कोड';
  }

  @override
  String get donatePayUpiId => 'UPI ID';

  @override
  String get donatePayCopy => 'UPI ID कॉपी करें';

  @override
  String get donatePayCopied => 'UPI ID कॉपी हो गई';

  @override
  String get donatePayOpenApp => 'इसी फ़ोन के UPI ऐप से भुगतान करें';

  @override
  String get donatePayReceipt => '80G रसीद के लिए मेरी जानकारी ईमेल करें';

  @override
  String get donatePayNote => 'AWSAR India को दान';
}
