import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:sample/app/routes/app_routes.dart';

class NavigationUtils {
  static const String _historyKey = 'nav_history';
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  /// Navigates to a route using [context.go] and updates the persistent history.
  /// Typically used for top-level navigation where the stack is reset.
  static void go(BuildContext context, String route) {
    _updateHistory(route, isReset: true);
    context.go(route);
  }

  /// Clears all persistent navigation history and navigates to a new route.
  /// Typically used after login to prevent users from going back to the login page.
  static void clearHistoryAndGo(BuildContext context, String route) {
    go(context, route);
  }

  /// Navigates to a route using [context.push] and appends to the persistent history.
  static void push(BuildContext context, String route) {
    _updateHistory(route);
    context.push(route);
  }

  /// Navigates to a route using [context.pushReplacement] and updates the persistent history.
  static void replace(BuildContext context, String route) {
    _updateHistory(route, isReplace: true);
    context.pushReplacement(route);
  }

  /// Attempts to pop the current route.
  /// If it cannot pop (e.g., after a browser refresh), it retrieves the
  /// previous route from persistent storage and navigates back to it.
  static Future<void> pop(BuildContext context) async {
    if (context.canPop()) {
      _popFromHistory();
      context.pop();
    } else {
      final previousRoute = await _retrievePreviousRoute();
      if (previousRoute != null) {
        // Navigate back using go to avoid creating a new stack on top of 'empty' one
        context.go(previousRoute);
      } else {
        // Fallback to home if no history exists
        context.go(AppRoutes.groceriesHome);
      }
    }
  }

  /// Internal method to update the persisted history list.
  static Future<void> _updateHistory(String route,
      {bool isReset = false, bool isReplace = false}) async {
    try {
      List<String> history = await _getHistory();

      if (isReset) {
        history = [route];
      } else if (isReplace) {
        if (history.isNotEmpty) {
          history[history.length - 1] = route;
        } else {
          history = [route];
        }
      } else {
        // Avoid duplicate consecutive routes
        if (history.isEmpty || history.last != route) {
          history.add(route);
        }
      }

      await _storage.write(key: _historyKey, value: jsonEncode(history));
    } catch (e) {
      debugPrint('Error updating navigation history: $e');
    }
  }

  /// Internal method to remove the last route from history.
  static Future<void> _popFromHistory() async {
    try {
      List<String> history = await _getHistory();
      if (history.isNotEmpty) {
        history.removeLast();
        await _storage.write(key: _historyKey, value: jsonEncode(history));
      }
    } catch (e) {
      debugPrint('Error popping from navigation history: $e');
    }
  }

  /// Retrieves the previous route from history without removing it.
  static Future<String?> _retrievePreviousRoute() async {
    try {
      List<String> history = await _getHistory();
      if (history.length > 1) {
        // Remove current route (the one we are 'popping' from)
        history.removeLast();
        final previous = history.last;
        // Update history to reflect the new state
        await _storage.write(key: _historyKey, value: jsonEncode(history));
        return previous;
      }
    } catch (e) {
      debugPrint('Error retrieving previous route: $e');
    }
    return null;
  }

  /// Helper to get the history list from storage.
  static Future<List<String>> _getHistory() async {
    final data = await _storage.read(key: _historyKey);
    if (data == null) return [];
    try {
      return List<String>.from(jsonDecode(data));
    } catch (_) {
      return [];
    }
  }

  /// Clears all navigation history.
  static Future<void> clearHistory() async {
    await _storage.delete(key: _historyKey);
  }
}
