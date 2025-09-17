import json
import re
import os
from googletrans import Translator
from pathlib import Path

class FlutterTranslator:
    def __init__(self, project_path):
        self.project_path = Path(project_path)
        self.json_paths = {
            'en': self.project_path / 'assets/translations/language_en.json',
            'fr': self.project_path / 'assets/translations/language_fr.json',
            'ar': self.project_path / 'assets/translations/language_ar.json'
        }
        self.dart_path = self.project_path / 'lib/app/core/constants/strings_assets_constants.dart'
        self.translator = Translator()
        
    def detect_language(self, text):
        """Detect language with fallback"""
        try:
            return self.translator.detect(text).lang
        except:
            return 'en'
    
    def translate_text(self, text, src_lang, dest_lang):
        """Translate with error handling"""
        if src_lang == dest_lang:
            return text
        try:
            return self.translator.translate(text, src=src_lang, dest=dest_lang).text
        except Exception as e:
            print(f"Translation failed for '{text}': {e}")
            return text
    
    def generate_key(self, text, src_lang='en'):
        """Generate clean key from text"""
        if src_lang != 'en':
            try:
                text = self.translator.translate(text, src=src_lang, dest='en').text
            except:
                pass
        
        # Clean and format key
        key = re.sub(r'[^\w\s]', '', text.lower())
        key = re.sub(r'\s+', '_', key.strip())
        return key or f"key_{abs(hash(text)) % 10000}"
    
    def load_json(self, path):
        """Load JSON with error handling"""
        try:
            if path.exists():
                with open(path, 'r', encoding='utf-8') as f:
                    return json.load(f)
        except (json.JSONDecodeError, Exception) as e:
            print(f"Error loading {path}: {e}")
        return {}
    
    def save_json(self, path, data):
        """Save JSON with formatting"""
        path.parent.mkdir(parents=True, exist_ok=True)
        with open(path, 'w', encoding='utf-8') as f:
            json.dump(dict(sorted(data.items())), f, indent=2, ensure_ascii=False)
    
    def update_dart_file(self, key):
        """Add key to Dart constants file"""
        try:
            if not self.dart_path.exists():
                # Create basic Dart file structure if it doesn't exist
                self.dart_path.parent.mkdir(parents=True, exist_ok=True)
                with open(self.dart_path, 'w') as f:
                    f.write("import 'package:get/get.dart';\n\nclass StringsAssetsConstants {\n}\n")
            
            with open(self.dart_path, 'r', encoding='utf-8') as f:
                content = f.read()
            
            # Check if key already exists
            if f'get {key} =>' in content:
                return
            
            # Find insertion point and add new key
            new_line = f'  static String get {key} => "{key}".tr;\n'
            
            if content.strip().endswith('}'):
                content = content.rstrip().rstrip('}') + new_line + '}\n'
            else:
                content += new_line
                
            with open(self.dart_path, 'w', encoding='utf-8') as f:
                f.write(content)
                
        except Exception as e:
            print(f"Error updating Dart file: {e}")
    
    def process_phrases(self, phrases):
        """Main processing function"""
        # Load existing translations
        json_data = {lang: self.load_json(path) for lang, path in self.json_paths.items()}
        
        print(f"Processing {len(phrases)} phrases...")
        
        for phrase in phrases:
            phrase = phrase.strip()
            if not phrase:
                continue
                
            # Detect source language
            src_lang = self.detect_language(phrase)
            key = self.generate_key(phrase, src_lang)
            
            print(f"'{phrase}' ({src_lang}) -> key: {key}")
            
            # Skip if key already exists in all languages
            if all(key in json_data[lang] for lang in json_data):
                print(f"  Skipping - key '{key}' already exists")
                continue
            
            # Add original phrase
            json_data[src_lang][key] = phrase
            
            # Translate to other languages
            for lang in self.json_paths.keys():
                if lang != src_lang and key not in json_data[lang]:
                    translated = self.translate_text(phrase, src_lang, lang)
                    json_data[lang][key] = translated
                    print(f"  {lang}: {translated}")
            
            # Update Dart file
            self.update_dart_file(key)
        
        # Save all JSON files
        for lang, path in self.json_paths.items():
            self.save_json(path, json_data[lang])
            print(f"Updated {path}")
        
        print("✅ All translations completed!")

# Usage
if __name__ == "__main__":
    # Update this path to your Flutter project
    PROJECT_PATH = '/home/adel/Desktop/frantends/crasapp'
    
    # Your phrases to translate
    phrases_to_translate = [

    ]
    
    translator = FlutterTranslator(PROJECT_PATH)
    translator.process_phrases(phrases_to_translate)