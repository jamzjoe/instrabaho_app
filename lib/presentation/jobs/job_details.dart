import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class JobDetailScreen extends StatelessWidget {
  const JobDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {

    void sample(){
      print("print");
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Job Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark_border),
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "High Speed Studios",
                      style: TextStyle(
                        fontFamily: "Arial",
                        fontSize: 16,
                        color: Color(0xff303030)
                      )
                    ),
                    Text(
                      "Senior Software Engineer",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: "Arial",
                        fontSize: 22,
                        color: Color(0xff303030)
                      )
                    ),
                  ],
                ),
                Spacer(),
                Placeholder(
                  fallbackHeight: 100,
                  fallbackWidth: 100,
                )
              ],
            ),
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 3.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(
                      color: const Color(0xFFD2CFE8)
                    )
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Fulltime",
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF44347A),
                        fontWeight: FontWeight.bold,
                        fontFamily: "Arial"
                      )
                    )
                  )
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 3.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(
                      color: const Color(0xFFD2CFE8)
                    )
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Remote Working",
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF44347A),
                        fontWeight: FontWeight.bold,
                        fontFamily: "Arial"
                      )
                    )
                  )
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 3.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(
                      color: const Color(0xFFD2CFE8)
                    )
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Hourly",
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF44347A),
                        fontWeight: FontWeight.bold,
                        fontFamily: "Arial"
                      )
                    )
                  )
                )
              ]
            ),
            const Gap(5),
            Divider(color: Colors.grey[300]),
            Container(
                padding: const EdgeInsets.all(15.0),
                child: Column( 
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50.0),
                              color: const Color(0xffded1ff)
                            ),
                            child: const Icon(
                              Icons.monetization_on_outlined,
                              color: Color(0xff3d1997),
                              size: 55
                            )
                          ),
                          const Gap(20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Salary",
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 18
                                )
                              ),
                              const Text(
                                "\$500 - \$1000/monthly",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18
                                )
                              )
                            ]
                          )
                        ]
                      )
                    ),
                    const Gap(10),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50.0),
                              color: const Color(0xffded1ff)
                            ),
                            child: const Icon(
                              Icons.work_outline_outlined,
                              color: Color(0xff3d1997),
                              size: 55
                            )
                          ),
                          const Gap(20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Location",
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 18
                                )
                              ),
                              const Text(
                                "Medan, Indonesia",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18
                                )
                              )
                            ]
                          )
                        ]
                      )
                    )
                  ]
                )
              ),
            Container(
              alignment: Alignment.centerLeft,
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      "Job Details",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                      )
                    )
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.")
                  )
                ]
              )
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: const Color(0xff3d1997)
                        ),
                        child: const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 15
                        )
                      ),
                      const SizedBox(width: 10.0),
                      const Text("Ut enim ad minim veniam.")
                    ]
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: const Color(0xff3d1997)
                        ),
                        child: const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 15
                        )
                      ),
                      const SizedBox(width: 10.0),
                      const Text("Ut enim ad minim veniam.")
                    ]
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: const Color(0xff3d1997)
                        ),
                        child: const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 15
                        )
                      ),
                      const SizedBox(width: 10.0),
                      const Text("Ut enim ad minim veniam.")
                    ]
                  )
                ]
              )
            ),
            const Gap(15),
            Container(
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: sample,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[200],
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Icon(
                        Icons.bookmark_border_outlined,
                        color:  Color(0xff3d1997),
                        size: 25
                      ),
                    )
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: sample,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff3d1997),
                        foregroundColor: Colors.white
                      ), 
                      child: const Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Text(
                          "APPLY JOB",
                          style: TextStyle(
                            fontSize: 20
                          )
                        ),
                      )
                    ),
                  )
                  
                ]
              )
            ),
          ]
        )
      )
    );
  }
}