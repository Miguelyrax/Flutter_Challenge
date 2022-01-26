import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  final List<int> list=List.generate(16, (index) => index);
  late AnimationController _controller;
  late Animation<double> _animation;
  @override
  void initState() {
    _controller = AnimationController(duration:const Duration(milliseconds: 1000),vsync: this);
    _animation = Tween<double>(begin: 40.0, end: 0).animate(CurvedAnimation(parent: _controller, curve: Curves.ease));
    super.initState();
    
  }

  int? lastIndex;
  
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
                Flexible(
                  child: Container(
                    margin: EdgeInsets.all(16),        
                    decoration:BoxDecoration(  
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.white, width: 15)
                    ),
                    child: GridView.builder(
                      padding: EdgeInsets.all(0),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: list.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              childAspectRatio: 1,
                              
                              
                            ), itemBuilder: (_,i){
                              // i find the last item in the list
                              return list[i]==list.length-1
                              ?GestureDetector(
                                onTap: (){
                                  //if the lastindex is selected, the function can enter on the conditional
                                  if(lastIndex!=null){
                                    final element=list.removeAt(lastIndex!);
                                    list.insert(i, element);
                                    
                                  //this conditional is for lookup what element is >or<
                                    if(lastIndex!>i){
                                      final element2=list.removeAt(i+1);
                                      
                                      list.insert(lastIndex!, element2);
                                    }else{
                                      final element2=list.removeAt(i-1);
                                      
                                      list.insert(lastIndex!, element2);
                                    }
                                 _controller.reset();
                                    _controller.forward();

                   
                                  }
                                  setState(() {
                                    
                                  });
                                },
                                child: Container(color: Colors.transparent,))
                              :GestureDetector(
                                key: UniqueKey(),
                                onTap: (){
                                  lastIndex=i;
                                  setState(() {
                                    
                                  });
                                },
                                child: AnimatedBuilder(
                                  builder: (_,Widget? child){
                                    return Transform.translate(
                                      offset:Offset(0,0),
                                      child: child,
                                      )
                                      ;
                                  },
                                  animation: _controller,
                                  child: Container(
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
                                ),
                              );
                            }),
                  ),
                ),
              ],
            )
          ),
        ),
      ),
    );
  }
}