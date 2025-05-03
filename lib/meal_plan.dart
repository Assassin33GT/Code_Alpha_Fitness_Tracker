import 'package:fitness_tracker/form_container_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

TextEditingController calories = TextEditingController();
String selectedDiet = "Vegetarian";
List<String> dietOptions = [
  "Gluten Free",
  "Ketogenic",
  "Vegetarian",
  "Lacto-Vegetarian",
  "Ovo-Vegetarian",
  "Vegan",
  "Pescetarian",
  "Paleo",
  "Primal",
  "Low FODMAP",
  "Whole30",
];
String selectedIntolerance = "None";
List<String> selectedIntolerances = [];
List<String> intoleranceOptions = [
  "Dairy",
  "Egg",
  "paleo",
  "Gluten",
  "Grain",
  "Peanut",
  "Seafood",
  "Sesame",
  "Shellfish",
  "Soy",
  "Sulfite",
  "Tree Nut",
  "Wheat",
  "None",
];
int flag = 0;

class SpoonacularDietPlanner {
  final String apiKey = "29bbc8b420bf4005a12354619047140f";
  final String baseUrl = "https://api.spoonacular.com";

  SpoonacularDietPlanner();

  Future<Map<String, dynamic>?> getDietPlan({
    required int calories,
    String? diet,
    List<String>? intolerances,
  }) async {
    Map<String, String> params = {
      'apiKey': apiKey,
      'targetCalories': calories.toString(),
      'timeFrame': 'day',
    };

    if (diet != null) params['diet'] = diet;
    if (intolerances != null && intolerances.isNotEmpty) {
      params['intolerances'] = intolerances.join(',');
    }

    var uri = Uri.parse(
      "$baseUrl/mealplanner/generate",
    ).replace(queryParameters: params);

    try {
      final response = await http.get(uri);
      if (response.statusCode >= 400) {
        print("Error: ${response.statusCode}");
        return null;
      }

      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return data;
    } catch (e) {
      print("Exception: $e");
      return null;
    }
  }
}

class MealPlan extends StatefulWidget {
  const MealPlan({super.key});

  @override
  State<MealPlan> createState() => _MealPlanState();
}

class _MealPlanState extends State<MealPlan> {
  late final SpoonacularDietPlanner planner;

  Map<String, dynamic>? dietPlan;
  bool isLoading = false;
  String error = '';

  @override
  void initState() {
    super.initState();
    planner = SpoonacularDietPlanner();
  }

  Future<void> fetchPlan() async {
    setState(() {
      isLoading = true;
      error = '';
      dietPlan = null;
    });

    try {
      final result = await planner.getDietPlan(
        calories: calories.text.isNotEmpty ? int.parse(calories.text) : 2000,
        diet: selectedDiet,
        intolerances:
            selectedIntolerances.isEmpty ? null : selectedIntolerances,
      );

      if (result == null) {
        error = "Failed to fetch data. Check your API key or quota.";
      } else {
        dietPlan = result;
      }
      // }
    } catch (e) {
      error = "An error occurred: $e";
    }

    setState(() {
      isLoading = false;
    });
  }

  Widget buildPlan() {
    final meals = dietPlan?["meals"] ?? [];
    final nutrients = dietPlan?["nutrients"] ?? {};

    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.red.shade300, Colors.red.shade500],
                ),
              ),
              child: const Row(
                children: [
                  Icon(Icons.calendar_today, color: Colors.white),
                  SizedBox(width: 8),
                  Text(
                    "Today's Meal Plan",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...meals.asMap().entries.map((entry) {
                    final meal = entry.value;
                    return TweenAnimationBuilder(
                      tween: Tween<double>(begin: 0, end: 1),
                      duration: const Duration(milliseconds: 500),
                      builder: (context, double value, child) {
                        return Transform.translate(
                          offset: Offset(0, 20.0 * (1 - value)),
                          child: Opacity(
                            opacity: value,
                            child: Card(
                              elevation: 2,
                              margin: const EdgeInsets.only(bottom: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.restaurant,
                                          color: Colors.red.shade300,
                                        ),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Text(
                                            meal['title'],
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        const Icon(Icons.timer, size: 16),
                                        const SizedBox(width: 4),
                                        Text(
                                          "${meal['readyInMinutes']} mins",
                                          style: TextStyle(
                                            color: Colors.grey.shade600,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    InkWell(
                                      onTap: () async {
                                        final Uri url = Uri.parse(
                                          meal['sourceUrl'],
                                        );
                                        if (await canLaunchUrl(url)) {
                                          await launchUrl(
                                            url,
                                            mode:
                                                LaunchMode.externalApplication,
                                          );
                                        }
                                      },
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.link,
                                            size: 16,
                                            color: Colors.blue.shade400,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            "View Recipe",
                                            style: TextStyle(
                                              color: Colors.blue.shade400,
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                  const Divider(height: 32),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.monitor_heart, color: Colors.red),
                            SizedBox(width: 8),
                            Text(
                              "Nutrition Summary",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        _buildNutrientRow(
                          "Calories",
                          "${nutrients['calories'] ?? 'N/A'}",
                          Icons.local_fire_department,
                        ),
                        _buildNutrientRow(
                          "Protein",
                          "${nutrients['protein'] ?? 'N/A'}g",
                          Icons.fitness_center,
                        ),
                        _buildNutrientRow(
                          "Fat",
                          "${nutrients['fat'] ?? 'N/A'}g",
                          Icons.water_drop,
                        ),
                        _buildNutrientRow(
                          "Carbs",
                          "${nutrients['carbohydrates'] ?? 'N/A'}g",
                          Icons.grain,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNutrientRow(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.red.shade300),
          const SizedBox(width: 8),
          Text(label, style: const TextStyle(fontSize: 16)),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 50),
          // Calories input field
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: FormContainerWidget(
              controller: calories,
              hintText: "Enter the amount of calories",
              isPasswordField: false,
            ),
          ),
          const SizedBox(height: 20),
          // Dropdown for diet selection
          const Text(
            "Select Diet Type",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white70,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                //labelText: "Select Diet",
              ),
              value: selectedDiet,
              menuMaxHeight: 300,
              items: dietOptions.map((String diet) {
                return DropdownMenuItem<String>(
                  value: diet,
                  child: Text(diet),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedDiet = newValue!;
                });
              },
            ),
          ),
          const SizedBox(height: 20),
          // Dropdown for Intolerance
          const Text(
            "Select Intolerance Type",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white70,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
              value: selectedIntolerance,
              menuMaxHeight: 300,
              items: intoleranceOptions.map((String intolerance) {
                return DropdownMenuItem<String>(
                  value: intolerance,
                  child: Text(intolerance),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedIntolerance = newValue!;
                });
              },
            ),
          ),
          // print intolerances
          if (flag == 0)
            ...selectedIntolerances.map((String intolerance) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Card(
                  margin: const EdgeInsets.symmetric(vertical: 1),
                  child: ListTile(
                    title: Text(intolerance),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        setState(() {
                          selectedIntolerances.remove(intolerance);
                        });
                      },
                    ),
                  ),
                ),
              );
            }),
          const SizedBox(height: 10),
          // Button to add Intolerance
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.yellow.shade700,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(13),
              ),
            ),
            onPressed: () {
              setState(() {
                int i;
                flag = 0;
                for (i = 0; i < selectedIntolerances.length; i++) {
                  print(selectedIntolerances.length);
                  if (selectedIntolerances[i] == selectedIntolerance) {
                    break;
                  }
                }
                if (i == selectedIntolerances.length &&
                    selectedIntolerance != "None") {
                  selectedIntolerances.add(selectedIntolerance);
                }

                print(selectedIntolerances);
              });
            },
            child: const Text(
              "Add Intolerance",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Get new diet plan
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade500,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(13),
                  ),
                ),
                onPressed: () {
                  if (calories.text.isNotEmpty) {
                    flag = 1;
                    fetchPlan();
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Error"),
                          content: const Text(
                            "Please enter your calories.",
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text("OK"),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                child: const Text(
                  "Get New Meal Plan",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          if (isLoading)
            const Padding(
              padding: EdgeInsets.all(20),
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            ),
          if (error.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(error, style: const TextStyle(color: Colors.red)),
            ),
          if (dietPlan != null) buildPlan(),

          const SizedBox(height: 600),
        ],
      ),
    );
  }
}
