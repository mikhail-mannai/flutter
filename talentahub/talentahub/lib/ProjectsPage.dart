import 'package:flutter/material.dart';

class Project {
  String id;
  String title;
  DateTime date;
  String description;
  String exigence;
  String detail;
  String image;

  Project({
    required this.id,
    required this.title,
    required this.date,
    required this.description,
    required this.exigence,
    required this.detail,
    required this.image, required DateTime descrption, required String details,
  });
}

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({Key? key}) : super(key: key);

  @override
  _ProjectsPageState createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  final List<Project> projects = [
    Project(
      id: '1',
      title: 'Événement 1',
      date: DateTime.now(),
      descrption: DateTime.now(),
      exigence: 'Emplacement 1',
      details: 'aaaaa',
      image: 'lien_image_1', description: '', detail: '',
    ),
    
  ];

  

  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  List<Project> get filteredProjects {
    final query = _searchController.text.toLowerCase();
    return projects
        .where((project) =>
            project.id.toLowerCase().contains(query) ||
            project.title.toLowerCase().contains(query) ||
            project.date.toString().toLowerCase().contains(query) ||
            project.description.toLowerCase().contains(query) ||
            project.exigence.toLowerCase().contains(query) ||
            project.detail.toLowerCase().contains(query) ||
            project.image.toLowerCase().contains(query))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Projets'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 200, // Ajustez la largeur selon vos besoins
              child: TextField(
                controller: _searchController,
                onChanged: (_) => setState(() {}),
                decoration: InputDecoration(
                  hintText: 'Rechercher...',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  prefixIcon: Icon(Icons.search),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () {
                            _searchController.clear();
                            setState(() {});
                          },
                        )
                      : null,
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
            // Background Image
            Image.network(
              'assets/images/background1.jpg',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),

            // Centered White Bordered Container
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
                        label: Text('ID', style: TextStyle(color: Colors.black)),
                      ),
                      DataColumn(
                        label: Text('Title', style: TextStyle(color: Colors.black)),
                      ),
                      DataColumn(
                        label: Text('Date', style: TextStyle(color: Colors.black)),
                      ),
                      DataColumn(
                        label: Text('Description', style: TextStyle(color: Colors.black)),
                      ),
                      DataColumn(
                        label: Text('Exigence', style: TextStyle(color: Colors.black)),
                      ),
                      DataColumn(
                        label: Text('Detail', style: TextStyle(color: Colors.black)),
                      ),
                      DataColumn(
                        label: Text('Image', style: TextStyle(color: Colors.black)),
                      ),
                      DataColumn(
                        label: Text('Actions', style: TextStyle(color: Colors.black)),
                      ),
                    ],
                    rows: filteredProjects.map((project) {
                      return DataRow(
                        key: ValueKey<String>(project.id),
                        cells: [
                          DataCell(Text(project.id)),
                          DataCell(Text(project.title)),
                          DataCell(Text(project.date.toString())),
                          DataCell(Text(project.description)),
                          DataCell(Text(project.exigence)),
                          DataCell(Text(project.detail)),
                          DataCell(Text(project.image)),
                          DataCell(
                            Row(
                              children: [
                                IconButton(
                                  icon: Icon(Icons.edit, color: Colors.green),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return EditProjectDialog(project: project);
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
                                        return DeleteProjectDialog(project: project);
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

// Le reste du code inchangé

class EditProjectDialog extends StatefulWidget {
  final Project project;

  const EditProjectDialog({Key? key, required this.project}) : super(key: key);

  @override
  _EditProjectDialogState createState() => _EditProjectDialogState();
}

class _EditProjectDialogState extends State<EditProjectDialog> {
  late TextEditingController _idController;
  late TextEditingController _nameController;
  late TextEditingController _dateController;
  late TextEditingController _descriptionController;
  late TextEditingController _exigenceController;
  late TextEditingController _detailController;
  late TextEditingController _imageController;

  @override
  void initState() {
    super.initState();
    _idController = TextEditingController(text: widget.project.id);
    _nameController = TextEditingController(text: widget.project.title);
    _dateController = TextEditingController(text: widget.project.date.toString());
    _descriptionController = TextEditingController(text: widget.project.description);
    _exigenceController = TextEditingController(text: widget.project.exigence);
    _detailController = TextEditingController(text: widget.project.detail);
    _imageController = TextEditingController(text: widget.project.image);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Modifier le projet'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('ID'),
            TextField(controller: _idController),
            const SizedBox(height: 10),
            const Text('Title'),
            TextField(controller: _nameController),
            const SizedBox(height: 10),
            const Text('Date'),
            TextField(controller: _dateController),
            const SizedBox(height: 10),
            const Text('Description'),
            TextField(controller: _descriptionController),
            const SizedBox(height: 10),
            const Text('Exigence'),
            TextField(controller: _exigenceController),
            const SizedBox(height: 10),
            const Text('Detail'),
            TextField(controller: _detailController),
            const SizedBox(height: 10),
            const Text('Image'),
            TextField(controller: _imageController),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context); // Fermer la boîte de dialogue
          },
          child: const Text('Annuler'),
        ),
        TextButton(
          onPressed: () {
            // Appliquer les modifications au projet
            widget.project.id = _idController.text;
            widget.project.title = _nameController.text;
            widget.project.date = DateTime.parse(_dateController.text);
            widget.project.description = _descriptionController.text;
            widget.project.exigence = _exigenceController.text;
            widget.project.detail = _detailController.text;
            widget.project.image = _imageController.text;

            // Fermer la boîte de dialogue
            Navigator.pop(context);
          },
          child: const Text('Enregistrer'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _idController.dispose();
    _nameController.dispose();
    _dateController.dispose();
    _descriptionController.dispose();
    _exigenceController.dispose();
    _detailController.dispose();
    _imageController.dispose();
    super.dispose();
  }
}

class DeleteProjectDialog extends StatelessWidget {
  final Project project;

  const DeleteProjectDialog({Key? key, required this.project}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Confirmer'),
      content: Text('Voulez-vous vraiment supprimer ${project.title} ?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context); // Fermer la boîte de dialogue
          },
          child: const Text('Annuler'),
        ),
        TextButton(
          onPressed: () {
            // Action de suppression ici
            // Supprimer le projet de la liste ou de la base de données
            // ...

            // Fermer la boîte de dialogue
            Navigator.pop(context);
          },
          child: const Text('Confirmer'),
        ),
      ],
    );
  }
}
