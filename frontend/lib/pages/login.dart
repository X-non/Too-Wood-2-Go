import 'package:eatwise/constants/ew_colors.dart';
import 'package:eatwise/constants/ew_styles.dart';
import 'package:eatwise/models/company_item.dart';
import 'package:eatwise/widgets/ew_company_container.dart';
import 'package:eatwise/widgets/ew_company_container_small.dart';
import 'package:eatwise/widgets/ew_scaffold.dart';
import 'package:eatwise/widgets/ew_search_bar.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return EWScaffold(
      body: SizedBox(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(children: [
              const Icon(Icons.person, color: EWColors.darkgreen),
              const SizedBox(width: 10),
              Text(
                "Logga in",
                style:
                    EWTextStyles.titleBold.copyWith(color: EWColors.darkgreen),
              ),
            ]),
          ),
          const Expanded(child: Column()),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Eatwise',
                  style: EWTextStyles.titleBold
                      .copyWith(color: EWColors.darkgreen),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: SizedBox(
                  child: EWSearchBar(),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: SizedBox(
                  child: EWSearchBar(),
                ),
              ),
              const ElevatedButton(
                onPressed: null,
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll(EWColors.lightgreen),
                ),
                child: Text("Logga in"),
              ),
              const TextButton(
                onPressed: null,
                child: Text("Registrera dig"),
              ),
            ],
          ),
          const Expanded(child: Column()),
        ],
      )),
    );
  }
}
