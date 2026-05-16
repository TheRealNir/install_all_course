# Install All Course - התקנת סביבת פיתוח בלחיצה אחת

מתקין בלחיצה אחת לסטודנטים בקורס. הסקריפט מתקין את סביבת הפיתוח המלאה שצריך בשביל הקורס.

הסקריפטים בנויים להיות פשוטים, קריאים, ובטוחים להרצה חוזרת. הם מתקינים Cursor, לא VS Code.

> חשוב: להריץ סקריפטים רק מתוך ריפוזיטורי GitHub שאתם סומכים עליו.

## התחלה מהירה

### macOS

פתחו Terminal, הדביקו את הפקודה הזאת, ולחצו Enter:

```bash
curl -fsSL https://raw.githubusercontent.com/TheRealNir/install_all_course/main/mac/install.sh | bash
```

### Windows

פתחו PowerShell, הדביקו את הפקודה הזאת, ולחצו Enter:

```powershell
irm "https://raw.githubusercontent.com/TheRealNir/install_all_course/main/windows/install.bat" -OutFile install.bat; .\install.bat
```

אם Windows מבקש הרשאה, תאשרו. אם ההתקנה נכשלת בגלל הרשאות, פתחו PowerShell בתור Administrator והריצו שוב את הפקודה.

## מה מותקן

- Cursor
- Git
- Node.js LTS
- npm
- Bun
- Claude Code
- תוסף Claude Code ל-Cursor, אם הוא זמין

## אחרי ההתקנה

סגרו ופתחו מחדש את Terminal או PowerShell, ואז הריצו:

```bash
node --version
npm --version
bun --version
git --version
claude --version
```

אחר כך הפעילו את Claude Code:

```bash
claude
```

## מצב דיבוג

### macOS

```bash
curl -fsSL https://raw.githubusercontent.com/TheRealNir/install_all_course/main/mac/install.sh | bash -s -- --debug
```

### Windows

```powershell
.\install.bat -debug
```

## פתרון תקלות

- אם הפקודה `cursor` לא נמצאת, פתחו את Cursor פעם אחת והפעילו או התקינו את פקודת ה-shell ידנית אם צריך.
- אם Windows חוסם את הרצת הסקריפט, פתחו PowerShell בתור Administrator והריצו שוב את פקודת ההתקנה.
- אם macOS מבקש סיסמה בזמן התקנת Homebrew, השתמשו בסיסמת הכניסה למק.
- אם ההתקנה נכשלת, הריצו שוב את הפקודה. הסקריפט בטוח להרצה חוזרת ומדלג על כלים שכבר מותקנים.
- ודאו שיש חיבור אינטרנט יציב בזמן ההתקנה.

## הסרה

סקריפטי ההסרה מסירים את כלי הקורס כשאפשר, ונמנעים ממחיקת פרויקטים או קבצים אישיים.

### macOS

```bash
curl -fsSL https://raw.githubusercontent.com/TheRealNir/install_all_course/main/mac/uninstall.sh | bash
```

### Windows

```powershell
irm "https://raw.githubusercontent.com/TheRealNir/install_all_course/main/windows/uninstall.bat" -OutFile uninstall.bat; .\uninstall.bat
```

## מידע לפי מערכת הפעלה

- [README ל-macOS](mac/README.md)
- [README ל-Windows](windows/README.md)

## הערות בטיחות

- לא נוסף telemetry.
- לא נשלח מידע לריפוזיטורי הזה.
- הסקריפטים לא מוחקים פרויקטים של המשתמש.
- Node.js ו-nvm לא מוסרים אוטומטית על ידי סקריפטי ההסרה.
- Xcode Command Line Tools לא מוסר על ידי סקריפט ההסרה של macOS.
