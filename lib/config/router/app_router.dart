import 'package:go_router/go_router.dart';
import 'package:gemeni_app/presentation/screens/screens.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => HomeScreen()),
    GoRoute(path: '/basic-prompt', builder: (context, state) => BasicPromptScreen()),
    GoRoute(path: '/history-chat', builder: (context, state) => ChatContextScreen()),
    // Define your routes here
  ],
);