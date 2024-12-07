import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../provider/theme_provider.dart';
import '../../controllers/reflection_controller.dart';
import '../../models/reflection.dart';
import '../../models/theme.dart';
import '../../widgets/Reflections/past_reflections_screen.dart';
import 'package:hero_minds/widgets/Reflections/reflection_list_view.dart';

// Simulate a streak count for demonstration purposes
final streakCountProvider = Provider<int>((ref) => 5);

final reflectionControllerProvider = Provider<ReflectionController>((ref) {
  return ReflectionController();
});

class ReflectionsScreen extends ConsumerStatefulWidget {
  final Reflection? reflection;

  const ReflectionsScreen({super.key, this.reflection});

  @override
  ConsumerState<ReflectionsScreen> createState() => _ReflectionsScreenState();
}

class _ReflectionsScreenState extends ConsumerState<ReflectionsScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  String? selectedMood;
  bool isEditing = false;
  late String formattedDate;

  @override
  void initState() {
    super.initState();
    if (widget.reflection != null) {
      titleController.text = widget.reflection!.title;
      contentController.text = widget.reflection!.content;
      selectedMood = widget.reflection!.mood;
      isEditing = true;
    }
    formattedDate = DateFormat('MMMM d, yyyy').format(DateTime.now());

    // Add listeners to detect field changes
    titleController.addListener(_checkIfChanged);
    contentController.addListener(_checkIfChanged);
  }

  bool _hasChanges() {
    // Check if there are any changes made
    if (widget.reflection != null) {
      return titleController.text != widget.reflection!.title ||
          contentController.text != widget.reflection!.content ||
          selectedMood != widget.reflection!.mood;
    } else {
      return titleController.text.isNotEmpty ||
          contentController.text.isNotEmpty ||
          selectedMood != null;
    }
  }

  void _checkIfChanged() {
    setState(() {}); // Trigger UI update to enable/disable Cancel button
  }

  void saveReflection() {
    if (titleController.text.isEmpty || contentController.text.isEmpty) {
      // Show an error if fields are empty
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields before saving.'),
          duration: Duration(seconds: 2),
        ),
      );
      return; // Exit the function if validation fails
    }

    try {
      final reflectionListNotifier = ref.read(reflectionListProvider.notifier);

      final newReflection = widget.reflection?.copyWith(
            title: titleController.text,
            content: contentController.text,
            mood: selectedMood,
          ) ??
          Reflection(
            id: DateTime.now().toString(),
            title: titleController.text,
            content: contentController.text,
            createdAt: DateTime.now(),
            mood: selectedMood,
          );

      if (isEditing) {
        reflectionListNotifier.updateReflection(newReflection);
      } else {
        reflectionListNotifier.addReflection(newReflection);
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Reflection saved successfully!')),
      );

      clearFields();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to save reflection.')),
      );
    }
  }

  void clearFields() {
    titleController.clear();
    contentController.clear();
    setState(() {
      selectedMood = null;
      isEditing = false;
    });
  }

  void cancelEditing() {
    // Clear all input fields and reset the state
    titleController.clear();
    contentController.clear();
    setState(() {
      selectedMood = null;
      isEditing = false;
    });

    // Navigate back only if the user can pop back in the navigation stack
    if (Navigator.canPop(context)) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeNotifierProvider);
    final streakCount = ref.watch(streakCountProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Reflections",
          style: TextStyle(
            color: theme.textColor,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: theme.backgroundGradient[0],
        elevation: 4,
        centerTitle: false,
      ),
      body: Stack(
        children: [
          // Gradient Background
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: theme.backgroundGradient,
              ),
            ),
          ),
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    if (selectedMood != null)
                      Center(
                        child: Text(
                          selectedMood!,
                          style: const TextStyle(
                              fontSize: 48, fontWeight: FontWeight.bold),
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 16.0),
                      child: Text(
                        "Current Streak: $streakCount days",
                        style: TextStyle(
                          color: theme.textColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Text(
                        isEditing
                            ? "Editing your reflection. Update your thoughts."
                            : "Start a new reflection and capture your thoughts.",
                        style: TextStyle(
                          color: theme.textColor.withOpacity(0.9),
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    buildMoodSelector(theme),
                    const SizedBox(height: 16),
                    _buildTextField("Title", titleController, theme,
                        maxLines: 1),
                    const SizedBox(height: 16),
                    _buildTextField(
                        "Reflection Content", contentController, theme,
                        maxLines: 5),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "${contentController.text.length} / 500 characters",
                        style: TextStyle(
                          color: theme.textColor.withOpacity(0.6),
                          fontSize: 12,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: saveReflection,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: theme.backgroundColor,
                            foregroundColor: theme.textColor,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text('Save'),
                        ),
                        TextButton(
                          onPressed: _hasChanges() ? cancelEditing : null,
                          style: TextButton.styleFrom(
                            foregroundColor: _hasChanges()
                                ? theme.textColor.withOpacity(0.7)
                                : theme.textColor.withOpacity(0.4),
                          ),
                          child: const Text('Cancel'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const PastReflectionsScreen(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.backgroundColor, // Theme-based
                          foregroundColor: theme.textColor, // Theme-based
                          padding: const EdgeInsets.symmetric(
                              vertical: 14, horizontal: 24),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 4,
                        ),
                        child: const Text(
                          "View Past Notes",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMoodSelector(ThemeModel theme) {
    final moods = ["😀", "😐", "😢", "😡"];
    return Wrap(
      spacing: 12,
      children: moods.map((mood) {
        return ChoiceChip(
          label: Text(
            mood,
            style: const TextStyle(fontSize: 24),
          ),
          selected: selectedMood == mood,
          onSelected: (bool selected) {
            setState(() {
              selectedMood = selected ? mood : null;
            });
          },
          backgroundColor: theme.textColor.withOpacity(0.1),
          selectedColor: theme.backgroundColor.withOpacity(0.8),
          labelStyle: TextStyle(
            color: selectedMood == mood
                ? theme.textColor
                : theme.textColor.withOpacity(0.7),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildTextField(
      String label, TextEditingController controller, ThemeModel theme,
      {int? maxLines = 1}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      style: TextStyle(color: theme.textColor),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: theme.textColor.withOpacity(0.8)),
        hintText: 'Enter $label',
        hintStyle: TextStyle(color: theme.textColor.withOpacity(0.5)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: theme.borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: theme.borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: theme.textColor),
        ),
      ),
      onChanged: (text) {
        setState(() {});
      },
    );
  }
}
