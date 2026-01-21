import 'package:example/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:orkitt/orkitt.dart';
import '../widgets/balance_card.dart';
import '../widgets/action_button.dart';
import '../widgets/transaction_tile.dart';

final data = [
  TransactionTile(
    icon: Iconsax.card,
    title: "Apple Store",
    date: "Oct 10, 2025",
    amount: "- \$125.99",
    isDebit: true,
  ),
  TransactionTile(
    icon: Iconsax.arrow_down_1,
    title: "Received Payment",
    date: "Oct 9, 2025",
    amount: "+ \$540.00",
    isDebit: false,
  ),
  TransactionTile(
    icon: Iconsax.wallet_2,
    title: "Wallet Top-up",
    date: "Oct 6, 2025",
    amount: "+ \$1,000.00",
    isDebit: false,
  ),
];

class WalletXHomePage extends StatelessWidget {
  const WalletXHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    ComposeBox size = ComposeBox(849, 393);
    return Scaffold(
      appBar: customAppBar(context, child: _buildHeader(context)),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // Experimental Smart Unit Container
              // Uses min and max values to adapt to screen size
              // Will be released in future versions
              Container(
                width: 100.smart(minValue: 80, maxValue: 300),
                height: 50.smart(),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.smart()),
                  color: Colors.blue,
                ),
                child: Center(
                  child: Text(
                    "Smart Container",
                    style: TextStyle(
                      fontSize: 16.smartFont(fontMultiplier: 1.1),
                    ),
                  ),
                ),
              ),

              Container(
                height: size.h(100),
                width: size.w(100),
                color: Colors.red,
              ),

              24.s,
              Container(height: 100.w, width: 100.w, color: Colors.red),

              //OrkittLogo().center(),
              SizedBox(height: 20.h),
              const BalanceCard(),
              SizedBox(height: 28.h),
              _buildActionRow(),
              SizedBox(height: 32.h),
              Text(
                "Recent Transactions",
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: context.textPrimary,
                ),
              ),
              16.s,
              ...data.generateList(
                itemBuilder: (i) {
                  return data[i];
                },
              ),
            ],
          ).scrollable(),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: 24.px,
      color: context.background,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Orkitt", style: context.titleMedium.bold),

          Consumer(
            builder: (_, WidgetRef ref, __) {
              final manager = ref.watch(themeProvider);
              return UiThemeSwitch(manager: manager);
            },
          ).circular(color: context.surfaceElevated, radius: 24.r),
        ],
      ),
    );
  }

  Widget _buildActionRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        ActionButton(icon: Iconsax.arrow_up_1, label: "Send"),
        ActionButton(icon: Iconsax.arrow_down_1, label: "Receive"),
        ActionButton(icon: Iconsax.add_square, label: "Top-up"),
        ActionButton(icon: Iconsax.card, label: "Cards"),
      ],
    );
  }
}
