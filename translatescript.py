#!/usr/bin/env python3
import json
import re
import hashlib
import os
from googletrans import Translator

# ---------- CONFIG (keep your paths) ----------
JSON_PATHS = {
    'en': '/home/adel/Desktop/frantends/crasapp/assets/translations/language_en.json',
    'fr': '/home/adel/Desktop/frantends/crasapp/assets/translations/language_fr.json',
    'ar': '/home/adel/Desktop/frantends/crasapp/assets/translations/language_ar.json',
}
DART_PATH = '/home/adel/Desktop/frantends/crasapp/lib/app/core/constants/strings_assets_constants.dart'

translator = Translator()

# ---------- Helpers ----------
def safe_load_json(path):
    """Load JSON file safely, return empty dict if file doesn't exist or is invalid."""
    try:
        if not os.path.exists(path):
            # Create directory if it doesn't exist
            os.makedirs(os.path.dirname(path), exist_ok=True)
            return {}
        with open(path, 'r', encoding='utf-8') as f:
            return json.load(f)
    except (FileNotFoundError, json.JSONDecodeError) as e:
        print(f"Warning: Could not load {path}: {e}")
        return {}

def save_json(path, data):
    """Save data to JSON file with sorted keys."""
    try:
        # Create directory if it doesn't exist
        os.makedirs(os.path.dirname(path), exist_ok=True)
        sorted_data = {k: data[k] for k in sorted(data.keys())}
        with open(path, 'w', encoding='utf-8') as f:
            json.dump(sorted_data, f, indent=2, ensure_ascii=False)
        return True
    except Exception as e:
        print(f"Error saving {path}: {e}")
        return False

def read_file(path):
    """Read file content, return None if file doesn't exist."""
    try:
        with open(path, 'r', encoding='utf-8') as f:
            return f.read()
    except FileNotFoundError:
        print(f"Warning: File not found: {path}")
        return None

def write_file(path, content):
    """Write content to file."""
    try:
        # Create directory if it doesn't exist
        os.makedirs(os.path.dirname(path), exist_ok=True)
        with open(path, 'w', encoding='utf-8') as f:
            f.write(content)
        return True
    except Exception as e:
        print(f"Error writing {path}: {e}")
        return False

def normalize_lang(code):
    """Normalize language code to supported languages."""
    if code in JSON_PATHS:
        return code
    # Map common language variants
    lang_map = {
        'ar': 'ar',
        'ara': 'ar',
        'fr': 'fr',
        'fra': 'fr',
        'en': 'en',
        'eng': 'en'
    }
    return lang_map.get(code, 'en')

def clean_key(text):
    """Clean text to create a valid key name."""
    if not text:
        return None
    
    # Convert to lowercase and remove extra spaces
    t = str(text).strip().lower()
    # Replace sequences of non-alphanumeric characters with single underscore
    t = re.sub(r'[^a-z0-9]+', '_', t)
    # Remove leading/trailing underscores
    t = t.strip('_')
    
    # If empty or starts with number, add prefix
    if not t or t[0].isdigit():
        return f"key_{t}" if t else None
    
    return t

def short_hash(text, length=6):
    """Generate a short hash from text."""
    h = hashlib.sha256(str(text or "").encode('utf-8')).hexdigest()
    return h[:length]

def make_unique_key(base_key, existing_keys):
    """Generate a unique key by appending numbers if needed."""
    if not base_key:
        base_key = f"key_{short_hash('')}"
    
    key = base_key
    counter = 1
    while key in existing_keys:
        key = f"{base_key}_{counter}"
        counter += 1
    return key

# ---------- Translation functions ----------
def detect_language(text):
    """Detect language of text."""
    try:
        result = translator.detect(text)
        return result.lang if hasattr(result, 'lang') else 'en'
    except Exception as e:
        print(f"Language detection failed for '{text}': {e}")
        return 'en'

def translate_text(text, src_lang, dest_lang):
    """Translate text from source to destination language."""
    if src_lang == dest_lang or not text:
        return text
    
    try:
        result = translator.translate(text, src=src_lang, dest=dest_lang)
        return result.text if hasattr(result, 'text') else text
    except Exception as e:
        print(f"Translation failed from {src_lang} to {dest_lang} for '{text}': {e}")
        return text

def get_transliteration(text):
    """Try to get a transliterated version of the text for key generation."""
    try:
        # Try unidecode if available
        from unidecode import unidecode
        transliterated = unidecode(text)
        if transliterated and re.search(r'[A-Za-z0-9]', transliterated):
            return transliterated
    except ImportError:
        pass
    except Exception:
        pass
    
    # Fallback: try to get pronunciation from Google Translate
    try:
        result = translator.translate(text, dest='en')
        if hasattr(result, 'pronunciation') and result.pronunciation:
            return result.pronunciation
    except Exception:
        pass
    
    return None

# ---------- Dart file update ----------
def update_dart_file(dart_content, key):
    """Add getter method to Dart file if it doesn't exist."""
    if not dart_content:
        return f'''class StringsAssetsConstants {{
  static String get {key} => "{key}".tr;
}}'''
    
    # Check if the key already exists
    pattern = rf'\bstatic\s+String\s+get\s+{re.escape(key)}\s*=>'
    if re.search(pattern, dart_content):
        return dart_content
    
    # Find the last closing brace of the class
    insertion = f'  static String get {key} => "{key}".tr;\n'
    
    # Find the position to insert (before the last closing brace)
    last_brace_pos = dart_content.rfind('}')
    if last_brace_pos == -1:
        # If no closing brace found, append to the end
        return dart_content + '\n' + insertion
    
    # Insert before the last closing brace
    return dart_content[:last_brace_pos] + insertion + dart_content[last_brace_pos:]

# ---------- Main processing function ----------
def process_translations(phrases_list):
    """Process a list of phrases and add them to translation files."""
    if not phrases_list:
        print("No phrases to process.")
        return True
    
    # Load existing JSON data
    json_data = {}
    for lang, path in JSON_PATHS.items():
        json_data[lang] = safe_load_json(path)
    
    # Load Dart file
    dart_content = read_file(DART_PATH)
    if dart_content is None:
        print(f"Creating new Dart file at {DART_PATH}")
        dart_content = """class StringsAssetsConstants {
  // Auto-generated translation getters
}"""
    
    # Collect all existing keys
    existing_keys = set()
    for data in json_data.values():
        existing_keys.update(data.keys())
    
    print(f"Processing {len(phrases_list)} phrases...")
    print(f"Found {len(existing_keys)} existing keys")
    
    success_count = 0
    
    for i, phrase in enumerate(phrases_list, 1):
        print(f"\n[{i}/{len(phrases_list)}] Processing: '{phrase}'")
        
        if not phrase or not phrase.strip():
            print("  Skipping empty phrase")
            continue
            
        phrase = phrase.strip()
        
        # Check if phrase already exists in any language
        phrase_exists = False
        for lang_data in json_data.values():
            if phrase in lang_data.values():
                print(f"  Phrase already exists in translations, skipping")
                phrase_exists = True
                break
        
        if phrase_exists:
            continue
        
        # Detect source language
        detected_lang = detect_language(phrase)
        src_lang = normalize_lang(detected_lang)
        print(f"  Detected language: {detected_lang} -> {src_lang}")
        
        # Generate key
        key_candidate = None
        
        # If source is English, use it for key
        if src_lang == 'en' and re.search(r'[A-Za-z]', phrase):
            key_candidate = phrase
        else:
            # Try to get English translation first
            en_translation = translate_text(phrase, src_lang, 'en')
            if en_translation != phrase and re.search(r'[A-Za-z]', en_translation):
                key_candidate = en_translation
            else:
                # Try transliteration
                transliterated = get_transliteration(phrase)
                if transliterated:
                    key_candidate = transliterated
                else:
                    # Fallback to hash
                    key_candidate = f"{src_lang}_{short_hash(phrase)}"
        
        # Clean and make unique key
        clean_key_name = clean_key(key_candidate)
        if not clean_key_name:
            clean_key_name = f"key_{short_hash(phrase)}"
        
        final_key = make_unique_key(clean_key_name, existing_keys)
        existing_keys.add(final_key)
        
        print(f"  Generated key: '{final_key}'")
        
        # Generate translations for all languages
        translations = {}
        for lang in JSON_PATHS.keys():
            if lang == src_lang:
                translations[lang] = phrase
            else:
                translations[lang] = translate_text(phrase, src_lang, lang)
                print(f"    {lang}: '{translations[lang]}'")
        
        # Add to JSON data
        for lang in JSON_PATHS.keys():
            json_data[lang][final_key] = translations[lang]
        
        # Update Dart file
        dart_content = update_dart_file(dart_content, final_key)
        success_count += 1
    
    if success_count == 0:
        print("\nNo new translations were added.")
        return True
    
    # Save all files
    print(f"\nSaving {success_count} new translations...")
    
    # Save JSON files
    all_saved = True
    for lang, path in JSON_PATHS.items():
        if save_json(path, json_data[lang]):
            print(f"  ✓ Updated {os.path.basename(path)}")
        else:
            print(f"  ✗ Failed to update {os.path.basename(path)}")
            all_saved = False
    
    # Save Dart file
    if write_file(DART_PATH, dart_content):
        print(f"  ✓ Updated {os.path.basename(DART_PATH)}")
    else:
        print(f"  ✗ Failed to update {os.path.basename(DART_PATH)}")
        all_saved = False
    
    return all_saved

# ---------- Main execution ----------
if __name__ == "__main__":
    # Example phrases to translate
    translations_to_add = [



    ]
    
    print("Flutter Translation Manager")
    print("=" * 40)
    
    success = process_translations(translations_to_add)
    
    if success:
        print("\n✅ All translations processed successfully!")
        print("\nNext steps:")
        print("1. Run 'flutter pub get' to ensure dependencies are updated")
        print("2. Import the strings class in your Dart files where needed")
        print("3. Use the generated getters like: StringsAssetsConstants.hi")
    else:
        print("\n❌ Some errors occurred during processing.")
        print("Please check the error messages above and try again.")