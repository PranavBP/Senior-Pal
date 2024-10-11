// import 'package:flutter/material.dart';

// class DifficultCommunicationScreen extends StatefulWidget {
//   const DifficultCommunicationScreen({super.key});

//   @override
//   State<StatefulWidget> createState() {
//     return _DifficultCommunicationScreenState();
//   }
// }

// class _DifficultCommunicationScreenState
//     extends State<DifficultCommunicationScreen> {
//   final List<String> daysOfWeek = [
//     'Sunday',
//     'Monday',
//     'Tuesday',
//     'Wednesday',
//     'Thursday',
//     'Friday',
//     'Saturday'
//   ];

//   // List to store the answered state and responses for each day.
//   List<bool> answered = List.generate(7, (index) => false);

//   List<Map<String, String>> responses = List.generate(
//       7,
//       (index) => {
//             'communication': '',
//             'difficulty': '',
//             'wanted': '',
//             'otherWanted': '',
//             'feelings': '',
//           });

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 1000,
//       child: ListView.builder(
//         itemCount: daysOfWeek.length,
//         itemBuilder: (context, index) {
//           return _buildDayCard(index);
//         },
//       ),
//     );
//   }

//   Widget _buildDayCard(int index) {
//     return Card(
//       margin: const EdgeInsets.all(10),
//       child: ExpansionTile(
//         title: Text(daysOfWeek[index]),
//         subtitle: answered[index]
//             ? const Text('Answered', style: TextStyle(color: Colors.green))
//             : const Text('Not Answered', style: TextStyle(color: Colors.red)),
//         children: [
//           _buildTextField(
//               index,
//               'Describe the communication. With Whom? Subject?',
//               'communication'),
//           _buildTextField(
//               index, 'How did the difficulty come about?', 'difficulty'),
//           _buildTextField(index,
//               'What did you really want? What did you actually get?', 'wanted'),
//           _buildTextField(
//               index, 'What did the other person(s) want?', 'otherWanted'),
//           _buildTextField(index, 'How did you feel during and after this time?',
//               'feelings'),
//           ElevatedButton(
//             onPressed: () {
//               // Check if all fields for this day are filled
//               if (responses[index]
//                   .values
//                   .every((response) => response.isNotEmpty)) {
//                 setState(() {
//                   answered[index] = true;
//                 });
//               }
//             },
//             child: const Text('Submit'),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildTextField(int index, String labelText, String key) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//       child: TextField(
//         decoration: InputDecoration(
//           labelText: labelText,
//           border: const OutlineInputBorder(),
//         ),
//         onChanged: (value) {
//           setState(() {
//             responses[index][key] = value;
//           });
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class DifficultCommunicationScreen extends StatefulWidget {
  const DifficultCommunicationScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _DifficultCommunicationScreenState();
  }
}

class _DifficultCommunicationScreenState
    extends State<DifficultCommunicationScreen> {
  final List<String> daysOfWeek = [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday'
  ];

  // List to store the answered state and responses for each day.
  List<bool> answered = List.generate(7, (index) => false);

  List<Map<String, String>> responses = List.generate(
      7,
      (index) => {
            'communication': '',
            'difficulty': '',
            'wanted': '',
            'otherWanted': '',
            'feelings': '',
          });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 1000,
      child: ListView.builder(
        itemCount: daysOfWeek.length,
        itemBuilder: (context, index) {
          return _buildDayCard(index);
        },
      ),
    );
  }

  Widget _buildDayCard(int index) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: ExpansionTile(
        title: Text(daysOfWeek[index]),
        subtitle: answered[index]
            ? const Text('Answered', style: TextStyle(color: Colors.green))
            : const Text('Not Answered', style: TextStyle(color: Colors.red)),
        children: [
          _buildQuestionWithTextField(
              index,
              'Describe the communication. With whom? Subject?',
              'communication'),
          _buildQuestionWithTextField(
              index, 'How did the difficulty come about?', 'difficulty'),
          _buildQuestionWithTextField(
              index, 'What did you really want? What did you actually get?', 'wanted'),
          _buildQuestionWithTextField(
              index, 'What did the other person(s) want?', 'otherWanted'),
          _buildQuestionWithTextField(index,
              'How did you feel during and after this time?', 'feelings'),
          ElevatedButton(
            onPressed: () {
              // Check if all fields for this day are filled
              if (responses[index]
                  .values
                  .every((response) => response.isNotEmpty)) {
                setState(() {
                  answered[index] = true;
                });
              }
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionWithTextField(int index, String questionText, String key) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            questionText,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8.0),
          TextField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              setState(() {
                responses[index][key] = value;
              });
            },
          ),
        ],
      ),
    );
  }
}

