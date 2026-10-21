import 'package:flutter/material.dart';

import '../../../../core/content/models/opportunity.dart';
import '../../../../l10n/app_localizations.dart';

String opportunityTypeLabel(AppLocalizations l10n, OpportunityType t) => switch (t) {
  OpportunityType.scholarship => l10n.oppTypeScholarship,
  OpportunityType.mentorship => l10n.oppTypeMentorship,
  OpportunityType.internship => l10n.oppTypeInternship,
};

IconData opportunityTypeIcon(OpportunityType t) => switch (t) {
  OpportunityType.scholarship => Icons.payments_outlined,
  OpportunityType.mentorship => Icons.psychology_alt_outlined,
  OpportunityType.internship => Icons.work_outline,
};
