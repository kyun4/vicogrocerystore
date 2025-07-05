import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vico_grocery_store/services/counter_bloc.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});
  @override
  State<Profile> createState() => _profileState();
}

class _profileState extends State<Profile> {
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CounterBloc(),
      child: BlocBuilder<CounterBloc, int>(
        builder: (context, count) {
          return Scaffold(
            appBar: AppBar(),
            body: Container(
              height: MediaQuery.of(context).size.height,
              child: SafeArea(
                child: Column(
                  children: [
                    Container(
                      child: Center(
                        child: Text("$count", style: TextStyle(fontSize: 40)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            floatingActionButton: Container(
              margin: const EdgeInsets.only(bottom: 25, right: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FloatingActionButton(
                    heroTag: 'inc',
                    onPressed:
                        () => context.read<CounterBloc>().add(Increment()),
                    child: Icon(Icons.add),
                  ),
                  SizedBox(height: 5),
                  FloatingActionButton(
                    heroTag: 'dec',
                    onPressed:
                        () => context.read<CounterBloc>().add(Decrement()),
                    child: Icon(Icons.minimize),
                  ),
                  SizedBox(height: 5),
                  FloatingActionButton(
                    heroTag: "reset",
                    onPressed: () => context.read<CounterBloc>().add(Reset()),
                    child: Icon(Icons.reset_tv),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
