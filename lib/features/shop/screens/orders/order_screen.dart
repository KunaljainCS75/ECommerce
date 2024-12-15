import 'package:e_commercial_app/features/shop/screens/orders/widgets/orders_list.dart';
import 'package:e_commercial_app/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../utils/constants/sizes.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      /// AppBar
        appBar: TAppBar(title: Text('My Orders', style: Theme.of(context).textTheme.headlineSmall!.apply(fontWeightDelta: 2)), showBackArrow: false),
        body: Container(
          color: TColors.primary.withOpacity(0.1),
          child: const Padding(padding: EdgeInsets.all(TSizes.defaultSpace),

           /// Orders
          child:  OrdersListItems()
          ),
        )
    );
  }
}
