import 'package:flutter/material.dart';
import 'package:spotify_project/common/helpers/is_dark_mode.dart';

class BasicAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final bool hideBack;
  final bool? centerTitle;
  final Color? backgroundColor;
  final Widget? action;
  const BasicAppBar(
      {super.key,
      this.title,
      this.centerTitle,
      this.hideBack = false,
      this.action,
      this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor ?? Colors.transparent,
      elevation: 0,
      centerTitle: centerTitle,
      title: title,
      leading: hideBack
          ? null
          : IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    color: context.isDarkMode
                        ? Colors.white.withOpacity(0.03)
                        : Colors.black.withOpacity(0.03),
                    shape: BoxShape.circle),
                child: Center(
                    child: Icon(
                  Icons.arrow_back_ios_new,
                  size: 15,
                  color: context.isDarkMode ? Colors.white : Colors.black,
                )),
              )),
      actions: [action ?? const SizedBox.shrink()],
    );
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight); // kToolbarHeight = 56.0
}
