import 'package:flutter/widgets.dart';

const motionShort = Duration(milliseconds: 200);
const motionCurve = Curves.easeOutCubic;

/// [motionShort], or zero when the user turned animations off in settings.
Duration motionDuration(BuildContext context) => MediaQuery.disableAnimationsOf(context) ? Duration.zero : motionShort;
