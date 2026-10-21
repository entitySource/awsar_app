import 'package:flutter/material.dart';

/// Maps the Material Symbols names used in content JSON to icons.
IconData programmeIcon(String name) => switch (name) {
  'query_stats' => Icons.query_stats,
  'shield' => Icons.shield_outlined,
  'school' => Icons.school_outlined,
  'health_and_safety' => Icons.health_and_safety_outlined,
  'diversity_3' => Icons.diversity_3_outlined,
  'volunteer_activism' => Icons.volunteer_activism_outlined,
  'eco' => Icons.eco_outlined,
  'holiday_village' => Icons.holiday_village_outlined,
  'handshake' => Icons.handshake_outlined,
  _ => Icons.volunteer_activism_outlined,
};
