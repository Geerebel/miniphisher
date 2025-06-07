# MINIPHISHER

> ⚠️ **Disclaimer:** This tool is created for **educational purposes only**. Do not use it to target or harm others. The developer is not responsible for any misuse.

A simple phishing tool using PHP and Ngrok to simulate social media login pages and capture credentials for educational analysis and security awareness.

SORRY FOR THE CREDENTIAL LOGS JUST GO TO CREDS.TXT THEN REMOVE EVERYTHING INSIDE FOR EACH WEBSITE FILE.

---

## 📦 Features

- Multiple site templates: Facebook, Instagram, PayPal, TikTok
- Automatic Ngrok tunnel creation
- Captures credentials in real-time
- Minimal setup with clear output

---

## 📥 Installation

```bash
# Clone the repository
git clone https://github.com/Geerebel/miniphisher.git

# Navigate into the directory
cd miniphisher

# Make the main script executable
chmod +x miniphisher.sh

# Optional: Install required packages on Arch
sudo pacman -S php curl unzip wget figlet --needed

#optional: 🐱‍💻 Kali Linux / Debian / Ubuntu
sudo apt update && sudo apt install php curl unzip wget figlet -y

🚀 Usage: ./miniphisher.sh
