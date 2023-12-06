import 'package:flutter/material.dart';

class Event {
  final String id;
  String nom;
  String description;
  DateTime date;
  String localisation;
  String image;

  Event({
    required this.id,
    required this.nom,
    required this.description,
    required this.date,
    required this.localisation,
    required this.image,
  });
}

class EventPage extends StatefulWidget {
  const EventPage({Key? key}) : super(key: key);

  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  final List<Event> events = [
    Event(
      id: '1',
      nom: 'Événement 1',
      description: 'Description de l\'événement 1',
      date: DateTime.now(),
      localisation: 'Emplacement 1',
      image: 'lien_image_1',
    ),
    Event(
      id: '2',
      nom: 'Événement 2',
      description: 'Description de l\'événement 2',
      date: DateTime.now(),
      localisation: 'Emplacement 2',
      image: 'lien_image_2',
    ),
    // Ajoutez plus d'événements ici
  ];

  List<Event> filteredEvents = [];

  @override
  void initState() {
    super.initState();
    filteredEvents = events;
  }

  void filterEvents(String query) {
    setState(() {
      filteredEvents = events
          .where((event) => event.nom.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Événements'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 200, // Ajustez la largeur selon vos besoins
              child: TextField(
                onChanged: filterEvents,
                decoration: InputDecoration(
                  hintText: 'Rechercher par nom',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  prefixIcon: Icon(Icons.search),
                  suffixIcon: IconButton(
                    onPressed: () {
                      // Effacer le texte de recherche lorsqu'on clique sur l'icône de fermeture
                      filterEvents('');
                    },
                    icon: Icon(Icons.close),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        margin: const EdgeInsets.all(4),
        color: Colors.transparent,
        child: Stack(
          children: [
            Image.network(
              'assets/images/background1.jpg',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Center(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.black,
                    width: 2,
                  ),
                ),
                child: SingleChildScrollView(
                  child: DataTable(
                    columnSpacing: 16,
                    headingRowColor: MaterialStateColor.resolveWith((states) => Colors.indigo),
                    dataRowColor: MaterialStateColor.resolveWith((states) => Colors.grey[200]!),
                    columns: const [
                      DataColumn(
                        label: Text('Nom', style: TextStyle(color: Colors.black)),
                      ),
                      DataColumn(
                        label: Text('Description', style: TextStyle(color: Colors.black)),
                      ),
                      DataColumn(
                        label: Text('Date', style: TextStyle(color: Colors.black)),
                      ),
                      DataColumn(
                        label: Text('Localisation', style: TextStyle(color: Colors.black)),
                      ),
                      DataColumn(
                        label: Text('Image', style: TextStyle(color: Colors.black)),
                      ),
                      DataColumn(
                        label: Text('Actions', style: TextStyle(color: Colors.black)),
                      ),
                    ],
                    rows: filteredEvents.map((event) {
                      return DataRow(
                        key: ValueKey<String>(event.id),
                        cells: [
                          DataCell(Text(event.nom)),
                          DataCell(Text(event.description)),
                          DataCell(Text(event.date.toString())),
                          DataCell(Text(event.localisation)),
                          DataCell(Text(event.image)),
                          DataCell(
                            Row(
                              children: [
                                IconButton(
                                  icon: Icon(Icons.edit, color: Colors.green),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return EditEventDialog(event: event);
                                      },
                                    );
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete, color: Colors.red),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return DeleteEventDialog(event: event);
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EditEventDialog extends StatefulWidget {
  final Event event;

  const EditEventDialog({super.key, required this.event});

  @override
  _EditEventDialogState createState() => _EditEventDialogState();
}

class _EditEventDialogState extends State<EditEventDialog> {
  late TextEditingController _nomController;
  late TextEditingController _descriptionController;
  late TextEditingController _dateController;
  late TextEditingController _localisationController;
  late TextEditingController _imageController;

  @override
  void initState() {
    super.initState();
    _nomController = TextEditingController(text: widget.event.nom);
    _descriptionController = TextEditingController(text: widget.event.description);
    _dateController = TextEditingController(text: widget.event.date.toString());
    _localisationController = TextEditingController(text: widget.event.localisation);
    _imageController = TextEditingController(text: widget.event.image);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Modifier l\'événement'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Nom'),
            TextField(controller: _nomController),
            const SizedBox(height: 10),
            const Text('Description'),
            TextField(controller: _descriptionController),
            const SizedBox(height: 10),
            const Text('Date'),
            TextField(controller: _dateController),
            const SizedBox(height: 10),
            const Text('Localisation'),
            TextField(controller: _localisationController),
            const SizedBox(height: 10),
            const Text('Image'),
            TextField(controller: _imageController),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context); // Close the dialog
          },
          child: const Text('Annuler'),
        ),
        TextButton(
          onPressed: () {
            // Apply modifications to the event
            widget.event.nom = _nomController.text;
            widget.event.description = _descriptionController.text;
            // Add logic to convert the date from _dateController.text to a DateTime object
            // ...
            widget.event.localisation = _localisationController.text;
            widget.event.image = _imageController.text;

            // Close the dialog
            Navigator.pop(context);
          },
          child: const Text('Enregistrer'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _nomController.dispose();
    _descriptionController.dispose();
    _dateController.dispose();
    _localisationController.dispose();
    _imageController.dispose();
    super.dispose();
  }
}

class DeleteEventDialog extends StatelessWidget {
  final Event event;

  const DeleteEventDialog({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Confirmation'),
      content: Text('Voulez-vous vraiment supprimer ${event.nom} ?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context); // Close the dialog
          },
          child: const Text('Annuler'),
        ),
        TextButton(
          onPressed: () {
            // Delete action here
            // Remove the event from the list or database
            // ...

            // Close the dialog
            Navigator.pop(context);
          },
          child: const Text('Confirmer'),
        ),
      ],
    );
  }
}
