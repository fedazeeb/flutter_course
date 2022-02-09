import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProviderWael extends StatelessWidget {
  const ProviderWael({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (BuildContext context) {
          return Prov();
        },
        builder: (context, child) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Provider"),
            ),
            body: Column(
              children: [
                Text(context.watch<Prov>().name),
                ElevatedButton(
                  onPressed: () {
                    context.read<Prov>().changeName();
                  },
                  child: const Text("Rebuild with watch"),
                )
              ],
            ),
          );
        },
        // child: Scaffold(
        //   appBar: AppBar(
        //     title: const Text("Provider"),
        //   ),
        //   body: Column(
        //     children: [
        //       Text(context.watch<Prov>().name),
        //       ElevatedButton(
        //         onPressed: () {
        //           context.read<Prov>().changeName();
        //         },
        //         child: const Text("Rebuild with watch"),
        //       )
        //     ],
        //   ),
        // ),
    );
  }
}

class Prov extends ChangeNotifier {
  String name = "Welcome";

  changeName() {
    name = "Wael";
    notifyListeners();
  }
}
