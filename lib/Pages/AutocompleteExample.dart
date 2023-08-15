import 'package:flutter/material.dart';

class AutocompleteExample extends StatefulWidget {
  const AutocompleteExample({Key? key}) : super(key: key);

  @override
  State<AutocompleteExample> createState() => _AutocompleteExampleState();
}

class _AutocompleteExampleState extends State<AutocompleteExample> {
  static const List<String> _kOptions = <String>[
    'aardvark',
    'bobcat',
    'chameleon',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 15.0),
      child: Autocomplete<String>(
        optionsBuilder:
            (TextEditingValue textEditingValue) {
          if (textEditingValue.text == '') {
            return const Iterable<String>.empty();
          }
          return _kOptions.where((String option) {
            return option.contains(
                textEditingValue.text.toLowerCase());
          });
        },
        displayStringForOption: (String option) => option,
        fieldViewBuilder: (BuildContext context,
            TextEditingController fieldTextEditingController,
            FocusNode fieldFocusNode,
            VoidCallback onFieldSubmitted) {
          return TextField(
            controller: fieldTextEditingController,
            focusNode: fieldFocusNode,
            style: const TextStyle(fontWeight: FontWeight.bold),
            decoration: InputDecoration(
                hintText: "Password",
                fillColor: Colors.black,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0))),
          );
        },
        onSelected: (String selection) {
          print('Selected: ${selection}');
        },
        optionsViewBuilder: (BuildContext context,
            AutocompleteOnSelected<String> onSelected,
            Iterable<String> options) {
          return Align(
            alignment: Alignment.topLeft,
            child: Material(
              child: Container(
                width: 300,
                color: Colors.teal,
                child: ListView.builder(
                  itemCount: options.length,
                  itemBuilder: (BuildContext context, int index) {
                    final String option = options.elementAt(index);

                    return GestureDetector(
                      onTap: () {
                        onSelected(option);
                      },
                      child: ListTile(
                        title: Text(option,
                            style: const TextStyle(color: Colors.white)),
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}