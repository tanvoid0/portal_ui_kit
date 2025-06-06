import 'package:flutter/material.dart';
import 'package:portal_ui_kit/portal_ui_kit.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    ThemeProvider.createProvider(
      themes: [
        ...customThemes,
        // RetroTheme(),
        // RetroTheme.dark(),
        // RetroTheme.custom(
        //   name: 'Retro Green',
        //   primaryColor: const Color(0xFF4CAF50),
        //   backgroundColor: const Color(0xFFE8F5E9),
        //   textColor: const Color(0xFF1B5E20),
        // ),
      ],
      initialThemeName: 'Retro',
      initialThemeMode: ThemeMode.system,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const PortalApp();
  }
}



class PortalApp extends StatelessWidget {
  const PortalApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get the current theme and theme mode from the provider
    final themeData = context.themeData;
    final themeMode = context.themeMode;

    // Create a dark theme based on the current theme
    final darkThemeData = context.themeProvider.availableThemes
        .firstWhere(
          (theme) => theme.name == 'Retro Dark',
          orElse: () => RetroTheme.dark(),
        )
        .toThemeData();

    return MaterialApp(
      title: 'Portal UI Kit Demo',
      debugShowCheckedModeBanner: false,
      theme: themeData,
      darkTheme: darkThemeData,
      themeMode: themeMode,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  String _selectedTab = 'Buttons';

  @override
  void dispose() {
    _textController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Portal UI Kit Demo'),
        actions: [
          IconButton(
            icon: const Icon(Icons.palette),
            onPressed: () {
              _showThemeSwitcher(context);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildTabBar(),
          Expanded(
            child: _buildSelectedTab(),
          ),
        ],
      ),
      floatingActionButton: const ThemeSwitcherFab(),
    );
  }

  Widget _buildTabBar() {
    return SizedBox(
      height: 50,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildTab('Buttons'),
          _buildTab('Text Fields'),
          _buildTab('Cards'),
          _buildTab('Dialogs'),
          _buildTab('Theme'),
        ],
      ),
    );
  }

  Widget _buildTab(String name) {
    final isSelected = _selectedTab == name;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTab = name;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isSelected ? Theme.of(context).colorScheme.primary : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Text(
          name,
          style: TextStyle(
            color: isSelected ? Theme.of(context).colorScheme.primary : null,
            fontWeight: isSelected ? FontWeight.bold : null,
          ),
        ),
      ),
    );
  }

  Widget _buildSelectedTab() {
    switch (_selectedTab) {
      case 'Buttons':
        return _buildButtonsTab();
      case 'Text Fields':
        return _buildTextFieldsTab();
      case 'Cards':
        return _buildCardsTab();
      case 'Dialogs':
        return _buildDialogsTab();
      case 'Theme':
        return _buildThemeTab();
      default:
        return _buildButtonsTab();
    }
  }

  Widget _buildButtonsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Button Variants', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              StyledButton(
                onPressed: () {},
                variant: ButtonVariant.primary,
                child: const Text('Primary'),
              ),
              // CodePreviewTabs(
              //   code: '''
              //   StyledButton(
              //     onPressed: () {},
              //     variant: ButtonVariant.primary,
              //     child: const Text('Code Preview'),
              //   )
              //   ''',
              //   child: StyledButton(
              //     onPressed: () {},
              //     variant: ButtonVariant.primary,
              //     child: const Text('Code Preview'),
              //   )
              // ),
              StyledButton(
                onPressed: () {},
                variant: ButtonVariant.secondary,
                child: const Text('Secondary'),
              ),
              StyledButton(
                onPressed: () {},
                variant: ButtonVariant.success,
                child: const Text('Success'),
              ),
              StyledButton(
                onPressed: () {},
                variant: ButtonVariant.danger,
                child: const Text('Danger'),
              ),
              StyledButton(
                onPressed: () {},
                variant: ButtonVariant.outline,
                child: const Text('Outline'),
              ),
              StyledButton(
                onPressed: () {},
                variant: ButtonVariant.text,
                child: const Text('Text'),
              ),
            ],
          ),
          const SizedBox(height: 32),
          const Text('Button Sizes', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              StyledButton(
                onPressed: () {},
                size: ButtonSize.small,
                child: const Text('Small'),
              ),
              StyledButton(
                onPressed: () {},
                size: ButtonSize.medium,
                child: const Text('Medium'),
              ),
              StyledButton(
                onPressed: () {},
                size: ButtonSize.large,
                child: const Text('Large'),
              ),
            ],
          ),
          const SizedBox(height: 32),
          const Text('Icon Buttons', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              StyledIconButton(
                icon: Icons.favorite,
                onPressed: () {},
                variant: ButtonVariant.primary,
              ),
              StyledIconButton(
                icon: Icons.star,
                onPressed: () {},
                variant: ButtonVariant.secondary,
              ),
              StyledIconButton(
                icon: Icons.check,
                onPressed: () {},
                variant: ButtonVariant.success,
              ),
              StyledIconButton(
                icon: Icons.delete,
                onPressed: () {},
                variant: ButtonVariant.danger,
              ),
              StyledIconButton(
                icon: Icons.info,
                onPressed: () {},
                variant: ButtonVariant.outline,
              ),
              StyledIconButton(
                icon: Icons.settings,
                onPressed: () {},
                variant: ButtonVariant.text,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTextFieldsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Text Fields', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          StyledTextField(
            controller: _textController,
            labelText: 'Standard Text Field',
            hintText: 'Enter some text',
          ),
          const SizedBox(height: 16),
          const StyledTextField(
            labelText: 'With Helper Text',
            hintText: 'Enter some text',
            helperText: 'This is a helper text',
          ),
          const SizedBox(height: 16),
          const StyledTextField(
            labelText: 'With Error',
            hintText: 'Enter some text',
            errorText: 'This field has an error',
          ),
          const SizedBox(height: 16),
          const StyledTextField(
            labelText: 'Disabled',
            hintText: 'This field is disabled',
            enabled: false,
          ),
          const SizedBox(height: 16),
          StyledTextField(
            labelText: 'Password',
            hintText: 'Enter your password',
            obscureText: true,
            prefixIcon: Icons.lock,
            suffixIcon: Icons.visibility,
            onSuffixIconPressed: () {
              // Toggle password visibility
            },
          ),
          const SizedBox(height: 32),
          const Text('Text Area', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          const StyledTextArea(
            labelText: 'Multiline Text Area',
            hintText: 'Enter multiple lines of text',
            minLines: 3,
            maxLines: 5,
          ),
          const SizedBox(height: 32),
          const Text('Search Field', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          StyledSearchField(
            controller: _searchController,
            hintText: 'Search...',
            onChanged: (value) {
              // Handle search
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCardsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Cards', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          const StyledCard(
            child: Text('Basic Card'),
          ),
          const SizedBox(height: 16),
          const StyledCard(
            title: 'Card with Title',
            child: Text('This card has a title'),
          ),
          const SizedBox(height: 16),
          const StyledCard(
            title: 'Card with Title and Subtitle',
            subtitle: 'This is a subtitle',
            child: Text('This card has a title and subtitle'),
          ),
          const SizedBox(height: 16),
          StyledCard(
            title: 'Card with Actions',
            actions: [
              IconButton(
                icon: const Icon(Icons.favorite),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.share),
                onPressed: () {},
              ),
            ],
            child: const Text('This card has actions in the header'),
          ),
          const SizedBox(height: 16),
          StyledCard(
            title: 'Card with Footer',
            footer: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {},
                  child: const Text('Cancel'),
                ),
                const SizedBox(width: 8),
                TextButton(
                  onPressed: () {},
                  child: const Text('OK'),
                ),
              ],
            ),
            child: const Text('This card has a footer'),
          ),
          const SizedBox(height: 32),
          const Text('Containers', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          const StyledContainer(
            child: Text('Basic Container'),
          ),
          const SizedBox(height: 16),
          const StyledContainer(
            borderRadius: 16,
            showShadow: true,
            child: Text('Container with Shadow'),
          ),
        ],
      ),
    );
  }

  Widget _buildDialogsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Dialogs', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          StyledButton(
            onPressed: () {
              _showCustomDialog(context);
            },
            child: const Text('Show Custom Dialog'),
          ),
          const SizedBox(height: 16),
          StyledButton(
            onPressed: () {
              _showInfoDialog(context);
            },
            variant: ButtonVariant.primary,
            child: const Text('Show Info Dialog'),
          ),
          const SizedBox(height: 16),
          StyledButton(
            onPressed: () {
              _showSuccessDialog(context);
            },
            variant: ButtonVariant.success,
            child: const Text('Show Success Dialog'),
          ),
          const SizedBox(height: 16),
          StyledButton(
            onPressed: () {
              _showWarningDialog(context);
            },
            variant: ButtonVariant.secondary,
            child: const Text('Show Warning Dialog'),
          ),
          const SizedBox(height: 16),
          StyledButton(
            onPressed: () {
              _showErrorDialog(context);
            },
            variant: ButtonVariant.danger,
            child: const Text('Show Error Dialog'),
          ),
          const SizedBox(height: 32),
          const Text('Toasts', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          StyledButton(
            onPressed: () {
              StyledToast.show(context, 'This is an info toast', type: ToastType.info);
            },
            variant: ButtonVariant.primary,
            child: const Text('Show Info Toast'),
          ),
          const SizedBox(height: 16),
          StyledButton(
            onPressed: () {
              StyledToast.show(context, 'This is a success toast', type: ToastType.success);
            },
            variant: ButtonVariant.success,
            child: const Text('Show Success Toast'),
          ),
          const SizedBox(height: 16),
          StyledButton(
            onPressed: () {
              StyledToast.show(context, 'This is a warning toast', type: ToastType.warning);
            },
            variant: ButtonVariant.secondary,
            child: const Text('Show Warning Toast'),
          ),
          const SizedBox(height: 16),
          StyledButton(
            onPressed: () {
              StyledToast.show(context, 'This is an error toast', type: ToastType.error);
            },
            variant: ButtonVariant.danger,
            child: const Text('Show Error Toast'),
          ),
        ],
      ),
    );
  }

  Widget _buildThemeTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Theme Selection', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          const Text('Dropdown Style'),
          const SizedBox(height: 8),
          const ThemeSwitcher(
            title: 'Select Theme',
            style: ThemeSwitcherStyle.dropdown,
          ),
          const SizedBox(height: 16),
          const Text('Radio Style'),
          const SizedBox(height: 8),
          const ThemeSwitcher(
            title: 'Select Theme',
            style: ThemeSwitcherStyle.radio,
          ),
          const SizedBox(height: 16),
          const Text('Button Style'),
          const SizedBox(height: 8),
          const ThemeSwitcher(
            title: 'Select Theme',
            style: ThemeSwitcherStyle.buttons,
          ),

          const SizedBox(height: 32),
          const Text('Theme Mode', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          const ThemeSwitcher(
            showThemeMode: true,
            showColorCustomization: false,
          ),

          const SizedBox(height: 32),
          const Text('Color Customization', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          const ThemeSwitcher(
            showThemeMode: false,
            showColorCustomization: true,
          ),

          const SizedBox(height: 32),
          const Text('Current Theme Properties', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _buildThemeProperties(),
        ],
      ),
    );
  }

  Widget _buildThemeProperties() {
    final themeConfig = context.themeConfig;
    final colorScheme = Theme.of(context).colorScheme;

    return StyledCard(
      title: 'Theme: ${themeConfig.name}',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Pixelated: ${themeConfig.pixelated}'),
          Text('Border Radius: ${themeConfig.borderRadius}'),
          Text('Border Width: ${themeConfig.borderWidth}'),
          const SizedBox(height: 16),
          const Text('Colors:'),
          _buildColorSwatch('Primary', colorScheme.primary),
          _buildColorSwatch('Secondary', colorScheme.secondary),
          _buildColorSwatch('Surface', colorScheme.surface),
          _buildColorSwatch('Background', colorScheme.surface),
          _buildColorSwatch('Error', colorScheme.error),
        ],
      ),
    );
  }

  Widget _buildColorSwatch(String name, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: color,
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(width: 8),
          Text('$name: ${_colorToHex(color)}'),
        ],
      ),
    );
  }

  String _colorToHex(Color color) {
    return '#${color.value.toRadixString(16).padLeft(8, '0').substring(2)}';
  }

  void _showThemeSwitcher(BuildContext context) {
    StyledDialog.show(
      context: context,
      title: 'Theme Settings',
      content: const SingleChildScrollView(
        child: ThemeSwitcher(
          style: ThemeSwitcherStyle.radio,
          showThemeMode: true,
          showColorCustomization: true,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        ),
      ],
    );
  }

  void _showCustomDialog(BuildContext context) {
    StyledDialog.show(
      context: context,
      title: 'Custom Dialog',
      content: const Text('This is a custom dialog with configurable content.'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('OK'),
        ),
      ],
    );
  }

  void _showInfoDialog(BuildContext context) {
    StyledAlertDialog.show(
      context: context,
      title: 'Information',
      message: 'This is an information dialog.',
      type: DialogType.info,
    );
  }

  void _showSuccessDialog(BuildContext context) {
    StyledAlertDialog.show(
      context: context,
      title: 'Success',
      message: 'Operation completed successfully!',
      type: DialogType.success,
    );
  }

  void _showWarningDialog(BuildContext context) {
    StyledAlertDialog.show(
      context: context,
      title: 'Warning',
      message: 'This action might have consequences.',
      confirmText: 'Proceed',
      cancelText: 'Cancel',
      type: DialogType.warning,
    );
  }

  void _showErrorDialog(BuildContext context) {
    StyledAlertDialog.show(
      context: context,
      title: 'Error',
      message: 'An error occurred while processing your request.',
      type: DialogType.error,
    );
  }
}
