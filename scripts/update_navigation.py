#!/usr/bin/env python3
"""
Script to update Flutter screens with safe navigation fixes.
This script will replace context.pop() calls with safePop() calls in the remaining screens.
"""

import os
import re
import glob

def update_file(file_path):
    """Update a single file with safe navigation fixes."""
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            content = f.read()
        
        original_content = content
        
        # Add import if not present
        if 'import \'../../core/router.dart\';' not in content:
            # Find the last import statement
            import_pattern = r'import \'[^\']+\';'
            imports = re.findall(import_pattern, content)
            if imports:
                last_import = imports[-1]
                content = content.replace(last_import, f"{last_import}\nimport '../../core/router.dart';")
        
        # Replace context.pop() with safePop(context)
        content = re.sub(
            r'context\.pop\(\)',
            'safePop(context)',
            content
        )
        
        # Replace onPressed: () => context.pop() with onPressed: () => safePop(context)
        content = re.sub(
            r'onPressed: \(\) => context\.pop\(\),',
            'onPressed: () => safePop(context),',
            content
        )
        
        # Replace onPressed: () => context.pop() with onPressed: () => safePop(context) (no comma)
        content = re.sub(
            r'onPressed: \(\) => context\.pop\(\)',
            'onPressed: () => safePop(context)',
            content
        )
        
        if content != original_content:
            with open(file_path, 'w', encoding='utf-8') as f:
                f.write(content)
            print(f"✅ Updated: {file_path}")
            return True
        else:
            print(f"⏭️  No changes needed: {file_path}")
            return False
            
    except Exception as e:
        print(f"❌ Error updating {file_path}: {e}")
        return False

def main():
    """Main function to update all Flutter screens."""
    print("🔄 Starting navigation fixes update...")
    
    # List of files that need updating
    files_to_update = [
        "lib/features/profile/profile_creation_screen.dart",
        "lib/features/courses/my_courses_screen.dart",
        "lib/features/courses/course_catalog_screen.dart",
        "lib/features/courses/course_detail_screen.dart",
        "lib/features/jobs/job_listings_screen.dart",
        "lib/features/jobs/job_detail_screen.dart",
        "lib/features/queries/query_list_screen.dart",
        "lib/features/queries/query_detail_screen.dart",
    ]
    
    updated_count = 0
    
    for file_path in files_to_update:
        if os.path.exists(file_path):
            if update_file(file_path):
                updated_count += 1
        else:
            print(f"⚠️  File not found: {file_path}")
    
    print(f"\n🎉 Navigation fixes update complete!")
    print(f"📊 Files updated: {updated_count}/{len(files_to_update)}")
    
    if updated_count > 0:
        print("\n📝 Next steps:")
        print("1. Run 'flutter analyze' to check for any syntax errors")
        print("2. Test the app to ensure navigation works correctly")
        print("3. Commit your changes with a descriptive message")

if __name__ == "__main__":
    main()
