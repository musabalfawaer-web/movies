import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Zeymar Movie', style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 22, color: Colors.white),),
        backgroundColor: Colors.red,
        actions: [
          IconButton(
            onPressed: () {}, icon: Icon(Icons.search), color: Colors.white,)
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
              children: [
                Row(
                  children: [
                    Text("Featured Movies",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16,color: Colors.red),),
                    const Spacer(),
                    TextButton(onPressed: () {},
                      child: Text(
                          "See All", style: TextStyle(color: Colors.red)),),
                  ],
                ),
                SizedBox(
                  height: 130,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    // itemCount: movies.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.all(8),
                        child: InkWell(
                          child: Column(
                            children: [
                              // Image.asset(movies[index].image, height: 60),
                              SizedBox(height: 10),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Row(
                  children: [
                    Text("Trending Movies",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16,color: Colors.red),),
                    const Spacer(),
                    TextButton(onPressed: () {},
                      child: Text(
                          "See All", style: TextStyle(color: Colors.red)),),

                  ],
                ),
                SizedBox(
                  height: 130,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    // itemCount: movies.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.all(8),
                        child: InkWell(
                          child: Column(
                            children: [
                              // Image.asset(movies[index].image, height: 60),
                              SizedBox(height: 10),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Row(
                  children: [
                    Text("New Movies",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16,color: Colors.red),),
                    const Spacer(),
                    TextButton(onPressed: () {},
                      child: Text(
                          "See All", style: TextStyle(color: Colors.red)),),
                  ],
                ),
                SizedBox(
                  height: 130,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    // itemCount: movies.length,
                    itemBuilder: (context, index) {
                      return Container(
                        color: Colors.black,
                        margin: EdgeInsets.all(8),
                        child: InkWell(
                          child: Column(
                            children: [
                              // Image.asset(movies[index].image, height: 60),
                              SizedBox(height: 10),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

              ]
          ),

        ),
      ),
    );
  }
}

