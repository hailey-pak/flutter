import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_actual/model/user_model.dart';
import 'package:go_router_actual/screen/1_screen.dart';
import 'package:go_router_actual/screen/2_screen.dart';
import 'package:go_router_actual/screen/3_screen.dart';
import 'package:go_router_actual/screen/error_screen.dart';
import 'package:go_router_actual/screen/home_screen.dart';
import 'package:go_router_actual/screen/login_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authStateProvider = AuthNotifier(
    ref: ref,
  );

  return GoRouter(
    initialLocation: '/login',
    errorBuilder: (context, state) {
      return ErrorScreen(
        error: state.error.toString(),
      );
    },
    // redirect
    redirect: authStateProvider._redirectLogic,
    // refresh --> 상태가 바뀔때마다 redirect를 실행
    refreshListenable: authStateProvider,
    routes: authStateProvider._routes,
  );
});

class AuthNotifier extends ChangeNotifier {
  final Ref ref;

  AuthNotifier({
    required this.ref,
  }) {
    ref.listen<UserModel?>(
      userProvider,
      (previous, next) {
        if (previous != next) {
          notifyListeners();
        }
      },
    );
  }

  FutureOr<String?> _redirectLogic(BuildContext context, GoRouterState state) {
    final user = ref.read(userProvider);

    // 로그인을 하려는 상태인지
    final loggingIn = state.location == '/login';

    // 유저 정보가 없는 경우
    // 현재 로그인을 하려는 상태라면 화면 이동 x
    // 로그인 페이지에 없다면 로그인 페이지로 이동
    if (user == null) {
      return loggingIn ? null : '/login';
    }

    // 유저 정보가 있는데 로그인 페이지라면 홈으로 이동
    if (loggingIn) {
      return '/';
    }

    return null;
  }

  List<GoRoute> get _routes => [
        GoRoute(
          path: '/',
          builder: (context, state) => const HomeScreen(),
          routes: [
            GoRoute(
              path: 'one',
              builder: (context, state) => const OneScreen(),
              routes: [
                GoRoute(
                  path: 'two',
                  builder: (context, state) => const TwoScreen(),
                  routes: [
                    // http://.../one/two/three
                    GoRoute(
                      path: 'three',
                      name: ThreeScreen.routeName,
                      builder: (context, state) => const ThreeScreen(),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        GoRoute(
          path: '/login',
          builder: (context, state) => const LoginScreen(),
        ),
      ];
}

final userProvider = StateNotifierProvider<UserStateNotifier, UserModel?>(
  (ref) => UserStateNotifier(),
);

// 로그인 한 상태라면 UserModel 인스턴스 상태로 넣어주기
// 로그아웃 상태라면 null 상태로 넣어주기
class UserStateNotifier extends StateNotifier<UserModel?> {
  UserStateNotifier() : super(null);

  login({
    required String name,
  }) {
    state = UserModel(name: name);
  }

  logout() {
    state = null;
  }
}
