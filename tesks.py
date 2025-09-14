import os
import re

# Create directories for Flutter/GetX modules
# This creates the folder structure for 4 different modules: editprofile, notification, notificationsettings, privacy
# Each module follows the GetX pattern with controllers, bindings, and views folders
modules = ['addcar']
folders = ['controllers', 'bindings', 'views']

def create_flutter_getx_structure():

    # Create base directory structure
    for module in modules:
        for folder in folders:
            directory = f"lib/app/modules/{module}/{folder}"
            os.makedirs(directory, exist_ok=True)
            print(f"Created directory: {directory}")
    
    # Create files for each module
    for module in modules:
        # Create controller file with proper content
        controller_path = f"lib/app/modules/{module}/controllers/{module}_controller.dart"
        controller_content = f'''import 'package:get/get.dart';

class {module.capitalize()}Controller extends GetxController {{
  // Add your controller logic here
}}
'''
        with open(controller_path, 'w') as f:
            f.write(controller_content)
        print(f"Created file: {controller_path}")
        
        # Create binding file with proper content
        binding_path = f"lib/app/modules/{module}/bindings/{module}_binding.dart"
        binding_content = f'''import 'package:get/get.dart';
import 'package:cars/app/modules/{module}/controllers/{module}_controller.dart';

class {module.capitalize()}Binding extends Bindings {{
  @override
  void dependencies() {{
    Get.lazyPut<{module.capitalize()}Controller>(() => {module.capitalize()}Controller());
  }}
}}
'''
        with open(binding_path, 'w') as f:
            f.write(binding_content)
        print(f"Created file: {binding_path}")
        
        # Create view file with proper content
        view_path = f"lib/app/modules/{module}/views/{module}_view.dart"
        view_content = f'''import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cars/app/core/constants/strings_assets_constants.dart';
import 'package:cars/app/core/styles/colors.dart';
import 'package:cars/app/core/styles/text_styles.dart';
import 'package:cars/app/modules/{module}/controllers/{module}_controller.dart';

class {module.capitalize()}View extends GetView<{module.capitalize()}Controller> {{
  {module.capitalize()}View({{Key? key}}) : super(key: key);

  @override
  Widget build(BuildContext context) {{
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          ' {module} Page ' ,
          style: TextStyles.titleSmall(context)
              .copyWith(color: MainColors.primaryColor),
        ),
      ),
      body: Center(
        child: Text(' This is the {module.capitalize()} page.'),
      ),
    );
  }}
}}
'''
        with open(view_path, 'w') as f:
            f.write(view_content)
        print(f"Created file: {view_path}")
    
    # Update app_pages.dart with new routes
    update_app_pages(modules)

def update_app_pages(modules):
    app_pages_path = "lib/app/routes/app_pages.dart"
    
    # Check if file exists
    if not os.path.exists(app_pages_path):
        print(f"Warning: {app_pages_path} not found. Cannot update routes.")
        return
    
    with open(app_pages_path, 'r') as f:
        content = f.read()
    
    # Add imports
    import_section = ""
    for module in modules:
        module_capitalized = module.capitalize()
        import_section += f"import 'package:cars/app/modules/{module}/bindings/{module}_binding.dart';\n"
        import_section += f"import 'package:cars/app/modules/{module}/views/{module}_view.dart';\n"
    
    content = re.sub(r'//here add  nesesary imports', f"//here add  nesesary imports\n{import_section}", content)
    
    # Add routes
    routes_section = ""
    for module in modules:
        module_capitalized = module.capitalize()
        routes_section += f"""    GetPage(
      name: _Paths.{module.upper()},
      page: () => {module_capitalized}View(),
      binding: {module_capitalized}Binding(),
    ),
"""
    
    content = re.sub(r' // hereadd the new files like the others', f" // hereadd the new files like the others\n{routes_section}", content)
    
    # Write updated content back to file
    with open(app_pages_path, 'w') as f:
        f.write(content)
    
    print(f"Updated routes in {app_pages_path}")
    
    # Now update app_routes.dart to add the route constants
    update_app_routes(modules)

def update_app_routes(modules):
    app_routes_path = "lib/app/routes/app_routes.dart"
    
    # Check if file exists
    if not os.path.exists(app_routes_path):
        print(f"Warning: {app_routes_path} not found. Cannot update route constants.")
        return
    
    with open(app_routes_path, 'r') as f:
        content = f.read()
    
    # Find the Routes class
    routes_match = re.search(r'abstract class Routes {[^}]*}', content, re.DOTALL)
    if not routes_match:
        print("Routes class not found in app_routes.dart")
        return
    
    routes_content = routes_match.group(0)
    new_routes_content = routes_content
    
    # Find the _Paths class
    paths_match = re.search(r'abstract class _Paths {[^}]*}', content, re.DOTALL)
    if not paths_match:
        print("_Paths class not found in app_routes.dart")
        return
    
    paths_content = paths_match.group(0)
    new_paths_content = paths_content
    
    # Add new route constants
    for module in modules:
        # Add to Routes class if not already there
        if module.upper() not in new_routes_content:
            new_route = f"  static const {module.upper()} = _Paths.{module.upper()};"
            new_routes_content = new_routes_content.replace('}', f'  {new_route}\n}}')
        
        # Add to _Paths class if not already there
        if module.upper() not in new_paths_content:
            new_path = f"  static const {module.upper()} = '/{module}';"
            new_paths_content = new_paths_content.replace('}', f'  {new_path}\n}}')
    
    # Replace the classes in the content
    content = content.replace(routes_content, new_routes_content)
    content = content.replace(paths_content, new_paths_content)
    
    # Write updated content back to file
    with open(app_routes_path, 'w') as f:
        f.write(content)
    
    print(f"Updated route constants in {app_routes_path}")

# Helper function to capitalize the first letter of a string
def capitalize_first(s):
    if not s:
        return s
    return s[0].upper() + s[1:]

if __name__ == "__main__":
    # Add the capitalize method to string if it doesn't exist
    if not hasattr(str, 'capitalize'):
        str.capitalize = capitalize_first
    
    create_flutter_getx_structure()
    print("Flutter/GetX project structure created successfully!")