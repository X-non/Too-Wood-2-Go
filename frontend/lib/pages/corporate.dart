import 'package:eatwise/constants/ew_colors.dart';
import 'package:eatwise/constants/ew_styles.dart';
import 'package:eatwise/models/company_item.dart';
import 'package:eatwise/models/product.dart';
import 'package:eatwise/widgets/ew_categori_searchbar.dart';
import 'package:eatwise/widgets/ew_product_widget.dart';
import 'package:eatwise/widgets/ew_scaffold.dart';
import 'package:flutter/material.dart';

class CorporatePage extends StatefulWidget {
  const CorporatePage({super.key, required this.item});

  final CompanyItem item;

  @override
  State<CorporatePage> createState() => _CorporatePageState();
}

class _CorporatePageState extends State<CorporatePage> {
  final ProductItem item = (ProductItem(
      img: 'assets/image/Gateau1.jpg',
      name: 'Vatten',
      priceOld: '100 kr',
      priceNew: '20 kr'));

  @override
  Widget build(BuildContext context) {
    return EWScaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 4),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.item.title,
                  style: EWTextStyles.titleBold,
                ),
              ),
            ),
            EWCompanyProfile(widget: widget),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: EWCategoriSearchbar(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: EWProductWidget(product: item),
            ),
          ],
        ),
      ),
    );
  }
}

class EWCompanyProfile extends StatefulWidget {
  const EWCompanyProfile({
    super.key,
    required this.widget,
  });

  final CorporatePage widget;

  @override
  State<EWCompanyProfile> createState() => _EWCompanyProfileState();
}

class _EWCompanyProfileState extends State<EWCompanyProfile> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: Stack(
        children: [
          Column(
            children: [
              const Spacer(),
              Container(
                height: 150,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Text(
                            widget.widget.item.address,
                            style: EWTextStyles.body,
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: Row(
                          children: [
                            Text(
                              'Öppet: ${widget.widget.item.openHours}',
                              style: EWTextStyles.body,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                width: double.infinity,
                height: 150,
                fit: BoxFit.fitWidth,
                widget.widget.item.img,
              ),
            ),
          ),
          Positioned(
            top: 100,
            left: 275,
            child: TextButton(
              onPressed: () {
                setState(() {
                  // Toggle the favorite status
                  widget.widget.item.favorite = !widget.widget.item.favorite;
                });
              }, // icon of the button
              style: TextButton.styleFrom(
                // styling the button
                foregroundColor: EWColors.primary,
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(20),
                backgroundColor: Colors.white, // Button color
                // Splash color
              ),
              child: Icon(
                widget.widget.item.favorite
                    ? Icons.favorite
                    : Icons.favorite_border_outlined,
                color: EWColors.darkgreen,
                size: 40,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
