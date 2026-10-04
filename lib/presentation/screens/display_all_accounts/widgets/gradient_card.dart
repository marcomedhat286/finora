import 'package:finora/domain/entities/account.dart';
import 'package:finora/presentation/dependencies/view_account_dependence.dart';
import 'package:finora/presentation/screens/display_all_accounts/widgets/card_content.dart';
import 'package:finora/presentation/screens/display_all_accounts/widgets/card_design_painter.dart';
import 'package:finora/presentation/screens/display_all_accounts/widgets/default_card_widget.dart';
import 'package:finora/presentation/screens/view_account/view/view_account.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GradientCard extends StatelessWidget {
  final Account? _account;
  final String type;
  final String title;
  final String accountId;
  final DateTime createdAt;
  final String currentBalance;
  final List<Color> colors;
  final bool isDefault;
  final VoidCallback? _onTap;

  const GradientCard({
    super.key,
    required this.type,
    required this.title,
    required this.accountId,
    required this.createdAt,
    required this.currentBalance,
    required this.colors,
    this.isDefault = false,
    this._account,
    this._onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        InkWell(
          onTap: () {
            if (_onTap != null) {
              _onTap();
            } else {
              navigateToViewAccount();
            }
          },
          child: Container(
            height: 200,
            width: double.infinity,
            margin: EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),

              // Background gradient
              gradient: RadialGradient(
                colors: colors,
                center: AlignmentGeometry.topRight,
                radius: 1.5,
                transform: GradientRotation(.5),
              ),

              // Soft shadow
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 15,
                  offset: const Offset(0, 8),
                ),
              ],
            ),

            // Clip the internal drawing so it stays inside the card.
            clipBehavior: Clip.antiAlias,

            child: Stack(
              children: [
                // ============================================================
                // INTERNAL CARD DESIGN
                // ============================================================
                Positioned.fill(
                  child: CustomPaint(painter: CardDesignPainter()),
                ),

                // ============================================================
                // CARD CONTENT
                // ============================================================
                CardContent(
                  type: type,
                  title: title,
                  accountId: accountId,
                  currentBalance: currentBalance,
                  createdAt: createdAt,
                ),
              ],
            ),
          ),
        ),
        (isDefault) ? const DefaultCardWidget() : const SizedBox(),
      ],
    );
  }

  void navigateToViewAccount() async {
    if (_account == null) return;

    await Get.to(
      () => ViewAccount(account: _account, colors: colors),
      binding: ViewAccountDependence(),
    );
  }
}
