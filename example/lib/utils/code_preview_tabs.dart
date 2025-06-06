import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/github.dart';

class CodePreviewTabs extends StatelessWidget {
  final Widget child;
  final String code;
  final String language;

  const CodePreviewTabs({
    Key? key,
    required this.child,
    required this.code,
    this.language = 'dart',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).colorScheme.outline),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            const TabBar(
              tabs: [
                Tab(text: 'Preview'),
                Tab(text: 'Code'),
              ],
              labelColor: Colors.black,
              indicatorColor: Colors.blue,
            ),
            Container(
              height: 300, // or use `Flexible` for dynamic height
              padding: const EdgeInsets.all(8),
              child: TabBarView(
                children: [
                  Center(child: child),
                  Stack(
                    children: [
                      SingleChildScrollView(
                        padding: const EdgeInsets.only(right: 40),
                        child: HighlightView(
                          code,
                          language: language,
                          theme: githubTheme,
                          padding: const EdgeInsets.all(12),
                          textStyle: const TextStyle(fontFamily: 'SourceCodePro'),
                        ),
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: IconButton(
                          tooltip: 'Copy',
                          icon: const Icon(Icons.copy, size: 18),
                          onPressed: () {
                            Clipboard.setData(ClipboardData(text: code));
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Code copied!')),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
