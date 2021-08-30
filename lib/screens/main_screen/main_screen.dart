import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:self_eticon_nasa/screens/detail_screen/detail_screen.dart';
import 'package:self_eticon_nasa/screens/main_screen/cubit/main_screen_cubit.dart';
import 'package:self_eticon_nasa/screens/main_screen/cubit/main_screen_state.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<bool> _isOpen = [false, false, false];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text('Eticon Mars Photo'),
          centerTitle: true,
        ),
        body: BlocBuilder<MainScreenCubit, MainScreenState>(
          builder: (context, state) {
            if (state is MainScreenLoadingState) {
              BlocProvider.of<MainScreenCubit>(context).getData();
              return Center(child: CupertinoActivityIndicator());
            }
            if (state is MainScreenErrorState) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(state.errorMsg),
                    SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        BlocProvider.of<MainScreenCubit>(context)
                            .emit(MainScreenLoadingState());
                      },
                      child: Container(
                        height: 30,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black, width: 2),
                        ),
                        child: Center(
                          child: Text(
                            'Retry',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            if (state is MainScreenLoadedState) {
              return ListView.builder(
                itemCount: state.result.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  DetailScreen(photo: state.result[index])));
                    },
                    child: Container(
                      margin:
                          EdgeInsets.fromLTRB(15, index == 0 ? 30 : 0, 15, 10),
                      height: 90,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Hero(
                                  tag:
                                      '${state.result[index].camera!.name!} ${state.result[index].id}',
                                  child: CircleAvatar(
                                    radius: 40,
                                    backgroundImage: NetworkImage(
                                        state.result[index].imgSrc!),
                                  )),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                '${state.result[index].camera!.name!} ${state.result[index].id}',
                              ),
                            ],
                          ),
                          Container(
                            height: 1,
                            color: Colors.black12,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
            return Container();
          },
        ));
  }
}
