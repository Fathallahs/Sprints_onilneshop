import 'package:flutter/material.dart';
import 'package:flutter_app/providers/auth_provider.dart';
import 'package:flutter_app/providers/cart_provider.dart';
import 'package:flutter_app/providers/product_provider.dart';
import 'package:flutter_app/providers/locale_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_app/l10n/app_localizations.dart';
import 'package:flutter_app/screens/product_detail_screen.dart';
import 'package:flutter_app/screens/cart_screen.dart';
import 'package:flutter_app/screens/orders_screen.dart';
import 'package:flutter_app/screens/main_tab_screen.dart';
import 'package:flutter_app/screens/auth_screen.dart';
import 'package:flutter_app/providers/orders_provider.dart';
import 'package:flutter_app/screens/forgot_password_screen.dart';
import 'package:flutter_app/screens/welcome_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => LocaleProvider()),
        ChangeNotifierProvider(create: (_) => OrdersProvider()),
      ],
      child: Consumer<LocaleProvider>(
        builder: (context, localeProvider, _) => MaterialApp(
        title: 'Flutter Shopping App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue).copyWith(
            secondary: Colors.blueAccent,
          ),
          fontFamily: 'Lato',
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
          ),
        ),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', ''),
          Locale('ar', ''),
        ],
        locale: localeProvider.locale,
        home: const WelcomeScreen(),
        routes: {
          ProductDetailScreen.routeName: (ctx) => const ProductDetailScreen(),
          CartScreen.routeName: (ctx) => const CartScreen(),
          '/orders': (ctx) => const OrdersScreen(),
          '/main': (ctx) => const MainTabScreen(),
          '/forgot-password': (ctx) => const ForgotPasswordScreen(),
        },
        ),
      ),
    );
  }
}
