import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  final List<int> list=List.generate(16, (index) {
    return index;
  });
  
  late AnimationController _controller;
  late Animation<double> _animation;
   Timer? timer;
    Duration timerInterval =const Duration(seconds: 1);
    int counter = 0;

    void stopTimer() {
      if (timer != null) {
        timer!.cancel();
        timer = null;
        counter = 0;
      }
    }
    String hoursStr='00';
    String minutesStr='00';
    String secondsStr='00';
    void tick(_) {
      counter++;
      setState(() {
        hoursStr = ((counter / (60 * 60)) % 60)
            .floor()
            .toString()
            .padLeft(2, '0');
        minutesStr = ((counter / 60) % 60)
            .floor()
            .toString()
            .padLeft(2, '0');
        secondsStr =
            (counter % 60).floor().toString().padLeft(2, '0');
      });
    }

    void startTimer() {
      timer = Timer.periodic(timerInterval, tick);
    }
  late int value;
  @override
  void initState() {
    list.shuffle();
    startTimer();
     value = list.indexOf(list[list.length-1]);
    _controller = AnimationController(duration:const Duration(milliseconds: 2000),vsync: this);
    _animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _controller, curve: Curves.ease));
    super.initState();
    
  }
  @override
  void dispose() {
    super.dispose();
  }

  int? lastIndex;
  format(Duration d) => d.toString().split('.').first.padLeft(8, "0");
  int grado=0;
  int moves=0;

  
  @override
  Widget build(BuildContext context) {


    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Scaffold(
        body: Center(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration:const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                Color(0xff288EEA),
                Color(0xff5AB2FF),
              ])
            ),
            child:Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                      'Flutter Challenge',
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800, color: Colors.white),
                      ),
                      const SizedBox(height: 16),
                 Text(
                      '$moves Moves',
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800, color: Color(0xff0652DD)),
                      ),
                      const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '$hoursStr:$minutesStr:$secondsStr',
                      style:const TextStyle(fontSize: 25, fontWeight: FontWeight.w800, color: Colors.white),
                      ),
                      const SizedBox(width: 10),
              const Icon(Icons.timer, color: Colors.white,size: 30,)
                  ],
                ),
                AnimatedContainer(
                      transformAlignment: Alignment.center,
                      duration: Duration(milliseconds: 1000),
                      // transform: Matrix4.identity()..rotateZ(pi*grado/2),
                      margin:const EdgeInsets.all(16),        
                      decoration:BoxDecoration(  
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.white, width: 15)
                      ),
                      child: GridView.builder(
                        padding:const EdgeInsets.all(0),
                        shrinkWrap: true,
                        physics:const NeverScrollableScrollPhysics(),
                        itemCount: list.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                                childAspectRatio: 1,
                                
                                
                              ), itemBuilder: (_,i){
                                // i find the last item in the list
                                return list[i]==list.length-1
                                ?Container(color: Colors.transparent,)
                                :GestureDetector(
                                  key: UniqueKey(),
                                  onTap: (){
                                    moves++;
                                    lastIndex=i;
                                    
                                    //if the lastindex is selected, the function can enter on the conditional
                                    if(lastIndex!=null){
                                      int? index;
                                       for (var element in list) {
                                         if(element==value){
                                          index = list.indexOf(element);
                                         }
                                      }
                                      if(i==index!-4 || i==index+4 || i==index+1||i==index-1){
                                        
                                        final element=list.removeAt(lastIndex!);
                                      list.insert(index, element);
                                      
                                    //this conditional is for lookup what element is >or<
                                      if(lastIndex!>index){
                                        final element2=list.removeAt(index+1);
                                        
                                        list.insert(lastIndex!, element2);
                                      }else{
                                        final element2=list.removeAt(index-1);
                                        
                                        list.insert(lastIndex!, element2);
                                      }
                                      lastIndex=null;
                                   grado++;
                                   
                    
                     
                                    }
                                  
                                    setState(() {
                                      
                                    });
                                      
                                    }
                                  },
                                  child: AnimatedContainer(
                                    key: UniqueKey(),
                                    transformAlignment: Alignment.center,
                      duration:const Duration(milliseconds: 3000),
                      // transform: Matrix4.identity()..rotateZ(pi*grado/2),
                                    decoration: BoxDecoration(
                                      boxShadow: [BoxShadow(
                                        color: Colors.black.withOpacity(0.5),
                                        spreadRadius: 0.9,
                                        blurRadius: 10
                                      )],
                                    color: Colors.red,
                                      border: Border.all(color: Colors.white),
                                      borderRadius: BorderRadius.circular(5)
                                    ),
                                    child:Center(child: Text(list[i].toString()),),
                                  ),
                                );
                              }),
                    )
              ],
            )
          ),
        ),
      ),
    );
  }
}