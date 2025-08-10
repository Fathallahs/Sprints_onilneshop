# 📱 How to Add Screenshots to Your Repository

## 🎯 Quick Solution

You have 5 screenshots that need to be added to the repository. Here's how to do it:

### Step 1: Save Screenshots from Your Device
Save the 5 screenshots you provided with these exact names:

1. **01_home_screen_english.png** - Home screen showing "Our Products" in English
2. **02_home_screen_arabic.png** - Home screen with Arabic language "منتجاتنا"
3. **03_welcome_screen.png** - Welcome screen with "Shopping App" title
4. **04_signup_screen.png** - Sign up screen with "Create Account" form
5. **05_signin_screen.png** - Sign in screen with "Welcome Back!" message

### Step 2: Copy Files to Repository
```bash
# Navigate to your project directory
cd /Users/Fathallah/Downloads/Sprint_pro/flutter_app

# Copy your screenshots to the screenshots directory
cp /path/to/your/screenshots/01_home_screen_english.png screenshots/
cp /path/to/your/screenshots/02_home_screen_arabic.png screenshots/
cp /path/to/your/screenshots/03_welcome_screen.png screenshots/
cp /path/to/your/screenshots/04_signup_screen.png screenshots/
cp /path/to/your/screenshots/05_signin_screen.png screenshots/
```

### Step 3: Commit and Push
```bash
# Add the new screenshot files
git add screenshots/*.png

# Commit the changes
git commit -m "Add actual app screenshots

- Added 5 PNG screenshots showing complete app functionality
- Home screen in English and Arabic languages
- Welcome screen with custom styling
- Authentication screens (Sign up/Sign in)
- Screenshots demonstrate bilingual support and UI features"

# Push to GitHub
git push origin main
```

## 🔄 Alternative: Use Git Commands Directly

If you prefer, you can also:

1. **Drag and drop** the PNG files directly into the `flutter_app/screenshots/` folder in VS Code
2. **Use Finder/File Explorer** to copy the files to the screenshots directory
3. **Use GitHub's web interface** to upload the files directly

## ✅ Verification

After adding the files, your screenshots directory should look like:
```
screenshots/
├── 01_home_screen_english.png
├── 02_home_screen_arabic.png
├── 03_welcome_screen.png
├── 04_signup_screen.png
├── 05_signin_screen.png
├── README.md
└── .gitkeep
```

