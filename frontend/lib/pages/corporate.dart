import 'package:eatwise/constants/EW_styles.dart';
import 'package:eatwise/constants/ew_colors.dart';
import 'package:eatwise/models/product.dart';
import 'package:eatwise/pages/home_page.dart';
import 'package:eatwise/widgets/ew_product_widget.dart';
import 'package:eatwise/widgets/ew_scaffold.dart';
import 'package:flutter/material.dart';

class CorporatePage extends StatelessWidget {
  CorporatePage({super.key});

  final ProductItem item = (ProductItem(
      img: 'assets/image/Gateau1.jpg',
      name: 'Vatten',
      priceOld: '100 kr',
      priceNew: '20 kr'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('This is the corporate page.'),
      ),
      body: Column(
        children: [
          const Padding(padding: EdgeInsets.all(8.0)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: EWProductWidget(product: item),
          ),
        ],
      ),
    );
    // return Center(
    //     child: Text(
    //   'Favorites Page',
    //   style: EWTextStyles.largeTitle.copyWith(color: EWColors.darkgreen),
    // ));
    // return const EWScaffold(
    //     body: Column(children: [
    //   Text("hahah"),
    //   IconButton(
    //     icon: Icon(Icons.add),
    //     onPressed: null,
    //     color: Colors.white,
    //   ),
    //   //EWProductWidget(),
    // ]));
  }
}
