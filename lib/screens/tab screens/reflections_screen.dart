import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hero_minds/widgets/Reflections/reflection_list_view.dart';
import 'package:intl/intl.dart';
import '../../provider/theme_provider.dart';
import '../../controllers/reflection_controller.dart';
import '../../models/reflection.dart';
import '../../models/theme.dart';
import '../../widgets/Reflections/past_reflections_screen.dart';

// Simulate a streak count for demonstration purposes
final streakCountProvider =
    Provider<int>((ref) => 5); // Replace with real logic if needed

final reflectionControllerProvider = Provider<ReflectionController>((ref) {
  return ReflectionController();
});

class ReflectionsScreen extends ConsumerStatefulWidget {
  final Reflection? reflection;

  const ReflectionsScreen({Key? key, this.reflection}) : super(key: key);

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
  }

  void saveReflection() {
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

      // Clear fields and reset states
      clearFields();
    } catch (e, stackTrace) {
      print('Error saving reflection: $e');
      print('Stack trace: $stackTrace');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to save reflection.')),
      );
    }
  }

  void clearFields() {
    print("Clearing fields..."); // Debugging print statement
    titleController.clear();
    contentController.clear();
    setState(() {
      selectedMood = null;
      isEditing = false;
    });
  }

  void cancelEditing() {
    if (titleController.text.isNotEmpty || contentController.text.isNotEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Discard Changes?'),
          content: const Text(
              'You have unsaved changes. Are you sure you want to cancel?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: const Text('Yes'),
            ),
          ],
        ),
      );
    } else {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeNotifierProvider);
    final streakCount = ref.watch(streakCountProvider);

    final isSaveEnabled = titleController.text.isNotEmpty &&
        contentController.text.isNotEmpty &&
        contentController.text.length <= 500;

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
        centerTitle: false,
      ),
      body: Stack(
        children: [
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
            top: 16,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (selectedMood != null)
                      Center(
                        child: Text(
                          selectedMood!,
                          style: TextStyle(fontSize: 48),
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 16.0),
                      child: Text(
                        "Current Streak: $streakCount days",
                        style: TextStyle(
                          color: theme.textColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Text(
                        isEditing
                            ? "Editing your reflection. Feel free to update your thoughts or feelings."
                            : "Start a new reflection and capture your thoughts for today.",
                        style: TextStyle(
                          color: theme.textColor.withOpacity(0.8),
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Text(
                        "What was the highlight of your day?",
                        style: TextStyle(
                          color: theme.textColor.withOpacity(0.8),
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                    Text(
                      formattedDate,
                      style: TextStyle(
                        color: theme.textColor.withOpacity(0.7),
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
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
                        maxLines: null),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "${contentController.text.length} / 500 characters",
                        style: TextStyle(
                          color: theme.textColor.withOpacity(0.5),
                          fontSize: 12,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: isSaveEnabled ? saveReflection : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: theme.backgroundColor,
                            foregroundColor: theme.textColor,
                          ),
                          child: const Text('Save'),
                        ),
                        TextButton(
                          onPressed: cancelEditing,
                          style: TextButton.styleFrom(
                            foregroundColor: theme.textColor.withOpacity(0.7),
                          ),
                          child: const Text('Cancel'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const PastReflectionsScreen(),
                            ),
                          );
                        },
                        child: Text(
                          "View Past Notes",
                          style: TextStyle(
                            color: theme.textColor,
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
      spacing: 10,
      children: moods.map((mood) {
        return ChoiceChip(
          label: Text(mood, style: const TextStyle(fontSize: 24)),
          selected: selectedMood == mood,
          onSelected: (bool selected) {
            setState(() {
              selectedMood = selected ? mood : null;
            });
          },
          backgroundColor: theme.textColor.withOpacity(0.1),
          selectedColor: theme.backgroundColor.withOpacity(0.7),
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
        labelStyle: TextStyle(color: theme.textColor.withOpacity(0.7)),
        hintText: 'Enter $label',
        hintStyle: TextStyle(color: theme.textColor.withOpacity(0.5)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: theme.borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: theme.borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: theme.textColor),
        ),
      ),
      onChanged: (text) {
        setState(() {}); // Trigger rebuild for character count update
      },
    );
  }
}
