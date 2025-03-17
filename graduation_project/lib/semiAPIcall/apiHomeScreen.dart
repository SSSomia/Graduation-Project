import 'package:flutter/material.dart';
import 'package:graduation_project/semiAPIcall/get_request.dart';
import 'package:provider/provider.dart';

class Apihomescreen extends StatelessWidget {
  const Apihomescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("API with Provider")),
      body: Consumer<DataProvider>(
        builder: (context, dataProvider, child) {
          return FutureBuilder(
            future: dataProvider.fetchData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              return ListView.builder(
                itemCount: dataProvider.items.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(dataProvider.items[index]['title']),
                  );
                },
              );
            },
          );
        },
      ),

      // body: Consumer<DataProvider>(
      //   builder: (context, dataProvider, child) {
      //     return FutureBuilder(
      //       future: dataProvider.sendData("somia", "srour"),
      //       builder: (context, snapshot) {
      //         if (snapshot.connectionState == ConnectionState.waiting) {
      //           return const Center(child: CircularProgressIndicator());
      //         }
      //         return ListView.builder(
      //           itemCount: dataProvider.items.length,
      //           itemBuilder: (context, index) {
      //             return ListTile(
      //               title: Text(dataProvider.items[index]['title']),
      //             );
      //           },
      //         );
      //       },
      //     );
      //   },
      // ),

      // body: Consumer<DataProvider>(
      //   builder: (context, dataProvider, child) {
      //     return FutureBuilder(
      //       future: dataProvider.updateData(1),
      //       builder: (context, snapshot) {
      //         if (snapshot.connectionState == ConnectionState.waiting) {
      //           return const Center(child: CircularProgressIndicator());
      //         }
      //         return ListView.builder(
      //           itemCount: dataProvider.items.length,
      //           itemBuilder: (context, index) {
      //             return ListTile(
      //               title: Text(dataProvider.items[index]['title']),
      //             );
      //           },
      //         );
      //       },
      //     );
      //   },
      // ),
    );
  }
}
