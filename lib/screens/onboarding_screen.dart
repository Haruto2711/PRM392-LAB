import 'package:flutter/material.dart';
import '../models/onboarding_item.dart';
import 'home_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() =>
      _OnboardingScreenState();
}

class _OnboardingScreenState
    extends State<OnboardingScreen> {
  final PageController controller =
      PageController();

  int currentPage = 0;

  final List<OnboardingItem> items = [
    OnboardingItem(
      image: "assets/images/feature1.jpg",
      title: "Tính Năng 1",
      description:
          "Tính năng giúp tăng hiệu suất làm việc.",
    ),
    OnboardingItem(
      image: "assets/images/feature2.jpg",
      title: "Tính Năng 2",
      description:
          "Quản lý dữ liệu nhanh chóng.",
    ),
    OnboardingItem(
      image: "assets/images/feature3.jpg",
      title: "Tính Năng 3",
      description:
          "Giao diện thân thiện với người dùng.",
    ),
  ];

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("GIỚI THIỆU TÍNH NĂNG"),
        centerTitle: true,
      ),

      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: controller,
              physics:
                  const BouncingScrollPhysics(),
              itemCount: items.length,

              onPageChanged: (index) {
                setState(() {
                  currentPage = index;
                });
              },

              itemBuilder: (context, index) {
                final item = items[index];

                return Padding(
                  padding:
                      const EdgeInsets.all(16),

                  child: Card(
                    elevation: 6,
                    shape:
                        RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(
                              20),
                    ),

                    child: Column(
                      children: [
                        const SizedBox(
                            height: 20),

                        SizedBox(
                          height: 250,
                          width:
                              double.infinity,

                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius
                                    .vertical(
                              top:
                                  Radius.circular(
                                      20),
                            ),
                            child: Image.asset(
                              item.image,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),

                        const SizedBox(
                            height: 20),

                        Text(
                          item.title,
                          style:
                              const TextStyle(
                            fontSize: 24,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),

                        const SizedBox(
                            height: 10),

                        Padding(
                          padding:
                              const EdgeInsets
                                  .symmetric(
                            horizontal: 20,
                          ),
                          child: Text(
                            item.description,
                            textAlign:
                                TextAlign.center,
                            style:
                                const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Indicator
          Row(
            mainAxisAlignment:
                MainAxisAlignment.center,

            children: List.generate(
              items.length,
              (index) => Container(
                margin:
                    const EdgeInsets.all(4),
                width:
                    currentPage == index
                        ? 12
                        : 8,
                height:
                    currentPage == index
                        ? 12
                        : 8,

                decoration:
                    BoxDecoration(
                  shape:
                      BoxShape.circle,
                  color:
                      currentPage == index
                          ? Colors.deepPurple
                          : Colors.grey,
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          Padding(
            padding:
                const EdgeInsets.symmetric(
              horizontal: 20,
            ),

            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment
                      .spaceBetween,

              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            const HomeScreen(),
                      ),
                    );
                  },
                  child:
                      const Text("BỎ QUA"),
                ),

                ElevatedButton(
                  onPressed: () {
                    if (currentPage <
                        items.length - 1) {
                      controller.nextPage(
                        duration:
                            const Duration(
                          milliseconds: 300,
                        ),
                        curve:
                            Curves.easeInOut,
                      );
                    } else {
                      Navigator
                          .pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              const HomeScreen(),
                        ),
                      );
                    }
                  },

                  child: Text(
                    currentPage ==
                            items.length - 1
                        ? "HOÀN TẤT"
                        : "TIẾP",
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
