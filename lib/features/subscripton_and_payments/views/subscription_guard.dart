import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yosrixia/core/utils/app_router.dart';
import 'package:yosrixia/features/subscripton_and_payments/manger/services/subscription_services.dart';

/// A widget that guards access to premium features based on subscription status
class SubscriptionGuard extends StatelessWidget {
  /// The widget to show if subscription is active
  final Widget child;

  /// The route to navigate to if no subscription (defaults to paymob view)
  final String? fallbackRoute;

  /// Whether to show loading indicator while checking subscription
  final bool showLoading;

  const SubscriptionGuard({
    super.key,
    required this.child,
    this.fallbackRoute,
    this.showLoading = true,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: SubscriptionServices.isSubscriptionActive(),
      builder: (context, snapshot) {
        // Show loading while checking subscription
        if (snapshot.connectionState == ConnectionState.waiting) {
          return showLoading
              ? const Center(child: CircularProgressIndicator())
              : child;
        }

        // Handle errors by showing subscription view
        if (snapshot.hasError) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            GoRouter.of(context).pushReplacement(
              fallbackRoute ?? AppRouter.paymobView,
            );
          });
          return const SizedBox.shrink();
        }

        final hasActiveSubscription = snapshot.data ?? false;

        if (hasActiveSubscription) {
          // User has active subscription, show the protected content
          return child;
        } else {
          // No active subscription, navigate to subscription view
          WidgetsBinding.instance.addPostFrameCallback((_) {
            GoRouter.of(context).pushReplacement(
              fallbackRoute ?? AppRouter.paymobView,
            );
          });
          return const SizedBox.shrink();
        }
      },
    );
  }
}

/// A navigation helper that checks subscription before navigating to games
class SubscriptionNavigationHelper {
  /// Checks subscription status and navigates accordingly
  static Future<void> navigateToGames(BuildContext context) async {
    try {
      final hasActiveSubscription =
          await SubscriptionServices.isSubscriptionActive();

      if (hasActiveSubscription) {
        // User has active subscription, navigate to games
        if (context.mounted) {
          GoRouter.of(context).push(AppRouter.gamesHome);
        }
      } else {
        // No active subscription, navigate to subscription view
        if (context.mounted) {
          GoRouter.of(context).push(AppRouter.subscriptionHome);
        }
      }
    } catch (e) {
      // On error, navigate to subscription view as fallback
      if (context.mounted) {
        GoRouter.of(context).push(AppRouter.subscriptionHome);
      }
    }
  }

  /// Checks subscription status and executes callback accordingly
  static Future<void> checkSubscriptionAndExecute(
    BuildContext context, {
    required VoidCallback onSubscriptionActive,
    VoidCallback? onSubscriptionInactive,
  }) async {
    try {
      final hasActiveSubscription =
          await SubscriptionServices.isSubscriptionActive();

      if (hasActiveSubscription) {
        onSubscriptionActive();
      } else {
        if (onSubscriptionInactive != null) {
          onSubscriptionInactive();
        } else {
          // Default behavior: navigate to subscription view
          if (context.mounted) {
            GoRouter.of(context).push(AppRouter.paymobView);
          }
        }
      }
    } catch (e) {
      // On error, execute inactive callback or navigate to subscription view
      if (onSubscriptionInactive != null) {
        onSubscriptionInactive();
      } else {
        if (context.mounted) {
          GoRouter.of(context).push(AppRouter.paymobView);
        }
      }
    }
  }
}
