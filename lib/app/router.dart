import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/about/presentation/about_screen.dart';
import '../features/account/presentation/account_screen.dart';
import '../features/about/presentation/contact_screen.dart';
import '../features/get_involved/presentation/donate_india_screen.dart';
import '../features/get_involved/presentation/donate_international_screen.dart';
import '../features/get_involved/presentation/get_involved_screen.dart';
import '../features/get_involved/presentation/handoff_sent_screen.dart';
import '../features/get_involved/presentation/volunteer_screen.dart';
import '../features/home/presentation/home_screen.dart';
import '../features/media/presentation/media_screen.dart';
import '../features/opportunities/presentation/opportunities_screen.dart';
import '../features/opportunities/presentation/opportunity_detail_screen.dart';
import '../features/programmes/presentation/programme_detail_screen.dart';
import '../features/programmes/presentation/programmes_screen.dart';
import '../features/settings/presentation/more_screen.dart';
import 'shell_scaffold.dart';

GoRouter buildRouter({String initialLocation = '/'}) => GoRouter(
  initialLocation: initialLocation,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, shell) => ShellScaffold(shell: shell),
      branches: [
        StatefulShellBranch(
          routes: [GoRoute(path: '/', builder: (_, _) => const HomeScreen())],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/programmes',
              builder: (_, _) => const ProgrammesScreen(),
              routes: [
                GoRoute(
                  path: ':id',
                  builder: (_, s) => ProgrammeDetailScreen(id: s.pathParameters['id']!),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/opportunities',
              builder: (_, _) => const OpportunitiesScreen(),
              routes: [
                GoRoute(
                  path: ':id',
                  builder: (_, s) => OpportunityDetailScreen(id: s.pathParameters['id']!),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/get-involved',
              builder: (_, _) => const GetInvolvedScreen(),
              routes: [
                GoRoute(path: 'donate-india', builder: (_, _) => const DonateIndiaScreen()),
                GoRoute(path: 'donate-international', builder: (_, _) => const DonateInternationalScreen()),
                GoRoute(path: 'volunteer', builder: (_, _) => const VolunteerScreen()),
                GoRoute(path: 'sent', builder: (_, _) => const HandoffSentScreen()),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/more',
              builder: (_, _) => const MoreScreen(),
              routes: [
                GoRoute(path: 'about', builder: (_, _) => const AboutScreen()),
                GoRoute(path: 'contact', builder: (_, _) => const ContactScreen()),
                GoRoute(path: 'media', builder: (_, _) => const MediaScreen()),
                GoRoute(path: 'account', builder: (_, _) => const AccountScreen()),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);

final routerProvider = Provider<GoRouter>((ref) => buildRouter());
