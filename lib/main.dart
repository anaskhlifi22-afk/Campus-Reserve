import 'package:flutter/material.dart';

void main() {
  runApp(const CampusReserveApp());
}

const Color navy = Color(0xFF173B70);
const Color blue = Color(0xFF2864B4);
const Color background = Color(0xFFF4F7FC);


class CampusReserveApp extends StatefulWidget {
  const CampusReserveApp({super.key});

  @override
  State<CampusReserveApp> createState() => _CampusReserveAppState();
}

class _CampusReserveAppState extends State<CampusReserveApp> {
  final List<Map<String, String>> accounts = [];
  Map<String, String>? currentUser;

  void register(String name, String email, String phone, String password) {
    accounts.add({
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
      'role': 'Étudiant',
    });
  }

  String? login(String email, String password) {
    for (final account in accounts) {
      if (account['email'] == email &&
          account['password'] == password) {
        setState(() {
          currentUser = account;
        });
        return null;
      }
    }
    return 'Email ou mot de passe incorrect.';
  }

  void logout() {
    setState(() {
      currentUser = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Campus Reserve',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Roboto',
        colorScheme: ColorScheme.fromSeed(seedColor: navy),
      ),
      home: currentUser == null
          ? WelcomeScreen(
        onLogin: login,
        onRegister: register,
        accounts: accounts,
        onSuccess: () => setState(() {}),
      )
          : HomeScreen(
       user: currentUser!,
        onLogout: logout,
      ),
    );
  }
}



Widget buildField({
  required TextEditingController controller,
  required String label,
  required IconData icon,
  TextInputType keyboardType = TextInputType.text,
  bool obscure = false,
  Widget? suffix,
  String? Function(String?)? validator,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 17),
    child: TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscure,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: navy),
        suffixIcon: suffix,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Color(0xFFE0E6EF)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: navy, width: 1.5),
        ),
      ),
    ),
  );
}



class WelcomeScreen extends StatelessWidget {
  final Function(String, String) onLogin;
  final Function(String, String, String, String) onRegister;
  final List<Map<String, String>> accounts;
  final VoidCallback onSuccess;

  const WelcomeScreen({
    super.key,
    required this.onLogin,
    required this.onRegister,
    required this.accounts,
    required this.onSuccess,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(25),
            child: Column(
              children: [
                const SizedBox(height: 35),
                Container(
                  height: 115,
                  width: 115,
                  decoration: BoxDecoration(
                    color: navy,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: navy.withOpacity(0.25),
                        blurRadius: 25,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.apartment_rounded,
                    color: Colors.white,
                    size: 65,
                  ),
                ),
                const SizedBox(height: 25),
                const Text(
                  'Campus Reserve',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: navy,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Réservation de salles et terrains',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.blueGrey, fontSize: 15),
                ),
                const SizedBox(height: 35),
                Container(
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 20,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'Bienvenue !',
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                          color: navy,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Réservez facilement vos espaces universitaires.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.blueGrey),
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: navy,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => LoginScreen(
                                  onLogin: onLogin,
                                ),
                              ),
                            ).then((_) => onSuccess());
                          },
                          child: const Text(
                            'Se connecter',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            foregroundColor: navy,
                            side: const BorderSide(color: navy),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => RegisterScreen(
                                  onRegister: onRegister,
                                  accounts: accounts,
                                ),
                              ),
                            );
                          },
                          child: const Text(
                            'Créer un compte',
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
                const SizedBox(height: 35),
                const Text(
                  'Université de Gafsa',
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



class RegisterScreen extends StatefulWidget {
  final Function(String, String, String, String) onRegister;
  final List<Map<String, String>> accounts;

  const RegisterScreen({
    super.key,
    required this.onRegister,
    required this.accounts,
  });

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();

  bool hidePassword = true;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmController.dispose();
    super.dispose();
  }

  void createAccount() {
    if (!formKey.currentState!.validate()) return;

    final email = emailController.text.trim().toLowerCase();

    final exists = widget.accounts.any(
          (account) => account['email'] == email,
    );

    if (exists) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Cet email existe déjà.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    widget.onRegister(
      nameController.text.trim(),
      email,
      phoneController.text.trim(),
      passwordController.text,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Compte créé avec succès !'),
        backgroundColor: Colors.green,
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: background,
        foregroundColor: navy,
        elevation: 0,
        title: const Text('Créer un compte'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(22),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Inscription',
                style: TextStyle(
                  color: navy,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Remplissez vos informations pour commencer.',
                style: TextStyle(color: Colors.blueGrey),
              ),
              const SizedBox(height: 30),
              buildField(
                controller: nameController,
                label: 'Nom complet',
                icon: Icons.person_outline,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Entrez votre nom.';
                  }
                  return null;
                },
              ),
              buildField(
                controller: emailController,
                label: 'Adresse Email',
                icon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null ||
                      !RegExp(r'^[^@]+@[^@]+\.[^@]+$')
                          .hasMatch(value.trim())) {
                    return 'Email invalide.';
                  }
                  return null;
                },
              ),
              buildField(
                controller: phoneController,
                label: 'Numéro de téléphone',
                icon: Icons.phone_outlined,
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Entrez votre numéro.';
                  }
                  return null;
                },
              ),
              buildField(
                controller: passwordController,
                label: 'Mot de passe',
                icon: Icons.lock_outline,
                obscure: hidePassword,
                suffix: IconButton(
                  onPressed: () {
                    setState(() => hidePassword = !hidePassword);
                  },
                  icon: Icon(
                    hidePassword
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.length < 6) {
                    return 'Minimum 6 caractères.';
                  }
                  return null;
                },
              ),
              buildField(
                controller: confirmController,
                label: 'Confirmer le mot de passe',
                icon: Icons.lock_reset,
                obscure: true,
                validator: (value) {
                  if (value != passwordController.text) {
                    return 'Les mots de passe ne correspondent pas.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: createAccount,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: navy,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: const Text(
                    "S'inscrire",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}



class LoginScreen extends StatefulWidget {
  final Function(String, String) onLogin;

  const LoginScreen({
    super.key,
    required this.onLogin,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool hidePassword = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void connect() {
    final error = widget.onLogin(
      emailController.text.trim().toLowerCase(),
      passwordController.text,
    );

    if (error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: background,
        foregroundColor: navy,
        elevation: 0,
        title: const Text('Connexion'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Icon(
              Icons.account_circle_rounded,
              size: 85,
              color: navy,
            ),
            const SizedBox(height: 20),
            const Text(
              'Bon retour !',
              style: TextStyle(
                fontSize: 29,
                color: navy,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Connectez-vous à votre compte.',
              style: TextStyle(color: Colors.blueGrey),
            ),
            const SizedBox(height: 35),
            buildField(
              controller: emailController,
              label: 'Adresse Email',
              icon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
            ),
            buildField(
              controller: passwordController,
              label: 'Mot de passe',
              icon: Icons.lock_outline,
              obscure: hidePassword,
              suffix: IconButton(
                onPressed: () {
                  setState(() => hidePassword = !hidePassword);
                },
                icon: Icon(
                  hidePassword
                      ? Icons.visibility_off
                      : Icons.visibility,
                ),
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: connect,
                style: ElevatedButton.styleFrom(
                  backgroundColor: navy,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text(
                  'Se connecter',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
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
class HomeScreen extends StatelessWidget {
  final Map<String, String> user;
  final VoidCallback onLogout;

  const HomeScreen({
    super.key,
    required this.user,
    required this.onLogout,
  });

  void openPage(BuildContext context, String title,
      IconData icon, String description) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => FeatureScreen(
          title: title,
          icon: icon,
          description: description,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isManager = user['role'] == 'Responsable';

    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: navy,
        title: const Text(
          'Campus Reserve',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              showDialog(
                context: context,
                builder: (dialogContext) => AlertDialog(
                  title: const Text('Déconnexion'),
                  content: const Text(
                    'Voulez-vous vraiment vous déconnecter ?',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () =>
                          Navigator.pop(dialogContext),
                      child: const Text('Annuler'),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: navy,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pop(dialogContext);
                        onLogout();
                      },
                      child: const Text('Déconnexion'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const SizedBox(height: 10),

            Text(
              'Bonjour, ${user['name'] ?? 'Étudiant'} 👋',
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: navy,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Bienvenue dans votre espace Campus Reserve.',
              style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 14,
              ),
            ),

            const SizedBox(height: 25),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [navy, blue],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.calendar_month,
                    color: Colors.white,
                    size: 35,
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Réservez votre espace universitaire',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Trouvez une salle ou un terrain '
                        'disponible en quelques clics.',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              'Nos services',
              style: TextStyle(
                color: navy,
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 18),

            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 15,
              crossAxisSpacing: 15,
              childAspectRatio: 1.05,
              children: [

                serviceCard(
                  context,
                  'Ressources',
                  Icons.apartment,
                  'Consulter les salles et terrains',
                  Colors.blue,
                  () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ResourcesScreen(),
                  ),
                );
              },
                  ),

                serviceCard(
                  context,
                  'Mes réservations',
                  Icons.calendar_month,
                  'Gérer mes réservations',
                  Colors.green,
                      () => openPage(
                    context,
                    'Mes réservations',
                    Icons.calendar_month,
                    'Retrouvez vos réservations à venir '
                        'et vos réservations passées.',
                  ),
                ),

                serviceCard(
                  context,
                  'Assistant IA',
                  Icons.smart_toy,
                  'Trouver un espace facilement',
                  Colors.deepPurple,
                      () => openPage(
                    context,
                    'Assistant IA',
                    Icons.smart_toy,
                    'Décrivez votre besoin et trouvez '
                        'les créneaux qui vous conviennent.',
                  ),
                ),

                if (isManager)
                  serviceCard(
                    context,
                    'Responsable',
                    Icons.admin_panel_settings,
                    'Gérer les ressources',
                    Colors.orange,
                        () => openPage(
                      context,
                      'Espace responsable',
                      Icons.admin_panel_settings,
                      'Gérez les ressources et consultez '
                          'les réservations.',
                    ),
                  ),
              ],
            ),

            const SizedBox(height: 30),

            const Text(
              'Prochaines réservations',
              style: TextStyle(
                color: navy,
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: const Color(0xFFE0E6EF),
                ),
              ),
              child: const Column(
                children: [
                  Icon(
                    Icons.event_available,
                    size: 45,
                    color: Colors.blueGrey,
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Aucune réservation pour le moment.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget serviceCard(
      BuildContext context,
      String title,
      IconData icon,
      String description,
      Color color,
      VoidCallback onTap,
      ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: const Color(0xFFE0E6EF),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                color: navy,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              description,
              style: const TextStyle(
                color: Colors.blueGrey,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FeatureScreen extends StatelessWidget {
  final String title;
  final IconData icon;
  final String description;

  const FeatureScreen({
    super.key,
    required this.title,
    required this.icon,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: navy,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 85,
                color: navy,
              ),
              const SizedBox(height: 25),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: navy,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                description,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.blueGrey,
                ),
              ),
              const SizedBox(height: 25),
              const Text(
                'Cette fonctionnalité sera développée '
                    'dans la prochaine étape.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class ResourcesScreen extends StatelessWidget {
  const ResourcesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: const Text(
          'Ressources',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: navy,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Choisissez une catégorie',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: navy,
            ),
          ),
          const SizedBox(height: 20),
          resourceCard(
            Icons.meeting_room,
            'Salles',
            'Consulter les salles disponibles',
            Colors.blue,
          ),
          resourceCard(
            Icons.science,
            'Laboratoires',
            'Consulter les laboratoires',
            Colors.deepPurple,
          ),
          resourceCard(
            Icons.sports_soccer,
            'Terrains',
            'Consulter les terrains sportifs',
            Colors.green,
          ),
        ],
      ),
    );
  }

  Widget resourceCard(
      IconData icon,
      String title,
      String description,
      Color color,
      ) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(15),
        leading: Icon(icon, color: color, size: 35),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: navy,
          ),
        ),
        subtitle: Text(description),
        trailing: const Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}