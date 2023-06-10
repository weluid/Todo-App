import 'package:flutter/material.dart';


class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late String _cityName;
  final Color _backgroundColor = const Color(0xFFf4f4fc);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // remove drop shadow
        elevation: 0,
        backgroundColor: _backgroundColor,
        centerTitle: true,
        title: Text("test"),
        titleTextStyle: const TextStyle(
          color: Colors.amber,
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ),
        iconTheme:  const IconThemeData(color: Colors.amber),
      ),
      backgroundColor: _backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(25),
              child: Form(
                child: TextFormField(
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  onChanged: (value) {
                    _cityName = value.toLowerCase().trim();
                  },
                ),
              ),
            ),
            TextButton(onPressed: (){
              Navigator.pop(context, _cityName);
            }, child: Text("Click"))

          ],
        ),
      ),
    );
  }
}
