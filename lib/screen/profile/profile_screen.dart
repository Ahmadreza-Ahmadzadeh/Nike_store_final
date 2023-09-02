import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike_store/data/auth_info.dart';
import 'package:nike_store/data/repo/auth_repository.dart';
import 'package:nike_store/data/repo/cart_repository.dart';
import 'package:nike_store/screen/auth/auth.dart';
import 'package:nike_store/screen/favorite/favorite_screen.dart';
import 'package:nike_store/screen/historyOrder/history_order.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("پروفایل"),
        centerTitle: true,
      ),
      body: ValueListenableBuilder<AuthInfo?>(
        valueListenable: AuthRepository.authChangeNotifier,
        builder: (context, authInfo, child) {
          final isLogin = authInfo != null && authInfo.accessToken.isNotEmpty;
          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  width: 65,
                  height: 65,
                  decoration: BoxDecoration(
                      border: Border.all(color: Theme.of(context).dividerColor),
                      shape: BoxShape.circle),
                  child: Image.asset(
                    "assets/img/nike_logo.png",
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(isLogin ? authInfo.email : "کاربر مهمان"),
                const SizedBox(
                  height: 35,
                ),
                const Divider(
                  height: 1,
                ),
                InkWell(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const FavoriteScreen(),
                  )),
                  child: Container(
                    height: 55,
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                    child: Row(
                      children: const [
                        Icon(CupertinoIcons.heart),
                        SizedBox(
                          width: 8,
                        ),
                        Text("لیست علاقه مندی ها")
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const HistoryOrderScreen(),
                    ));
                  },
                  child: Container(
                    height: 55,
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                    child: Row(
                      children: const [
                        Icon(CupertinoIcons.heart),
                        SizedBox(
                          width: 8,
                        ),
                        Text("سوابق سفارش")
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    if (isLogin) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return Directionality(
                              textDirection: TextDirection.rtl,
                              child: AlertDialog(
                                content: const Text("خروج از حساب کاربری"),
                                title: const Text(
                                    "آیا میخواهید از حساب کاربری خود خارج شوید "),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text("خیر")),
                                  TextButton(
                                      onPressed: () async {
                                        Navigator.of(context).pop();
                                        await authRepository.signOut();
                                        CartRepository.changeCountCart.value =
                                            0;
                                        if (AuthRepository
                                                .authChangeNotifier.value ==
                                            null) {
                                          // ignore: use_build_context_synchronously
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                                  content: Text(
                                                      "خروج با موفیقت انجام شد")));
                                        }
                                      },
                                      child: const Text("بله"))
                                ],
                              ),
                            );
                          });
                    } else {
                      Navigator.of(context, rootNavigator: true)
                          .push(MaterialPageRoute(
                        builder: (context) => const AuthScreen(),
                      ));
                    }
                  },
                  child: Container(
                    height: 55,
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                    child: Row(
                      children: [
                        Icon(isLogin
                            ? CupertinoIcons.arrow_right_square
                            : CupertinoIcons.arrow_left_square),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(isLogin
                            ? "خروج از حساب کاربری"
                            : "ورود به حساب کاربری")
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
