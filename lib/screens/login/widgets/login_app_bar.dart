import 'package:minimals/components/index.dart';
import 'package:flutter/material.dart';
import 'package:minimals/theme/overrides/index.dart';

class LoginAppBar extends StatelessWidget implements PreferredSizeWidget {
  const LoginAppBar({super.key, this.showLeadingIcon = true, this.hideHelp = false});
  final bool showLeadingIcon;
  final bool hideHelp;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: showLeadingIcon
          ? GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                margin: const EdgeInsets.only(left: 16),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle, // Makes the container circular
                  // Set your desired background color here
                ),
                child: const Icon(
                  Icons.arrow_back_ios_new,
                ),
              ),
            )
          : null,
      actions: !hideHelp
          ? <Widget>[
              Container(
                margin: const EdgeInsets.only(right: 16),
                child: CustomButton.text(
                  text: "Help",
                  minimumSize: const Size(64, 36),
                  color: ButtonColor.primary,
                  onPressed: () async {
                    showModalBottomSheet(
                      context: context,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0),
                        ),
                      ),
                      builder: (context) {
                        return Container();
                        // return  const ContactUsBottomSheet();
                      },
                    );
                  },
                ),
              ),
            ]
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50.0);
}
