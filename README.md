# 🛰️ Remote Evidence Collector

**Remote Evidence Collector** is a lightweight Bash script designed for digital forensics and incident response (DFIR). It allows you to remotely collect evidence from a compromised (sender) system to a collector (receiver) system over the network.

This updated version consolidates both sender and receiver functionality into **one interactive script**, making the process simpler and more flexible.

---

## ✨ Features

- ✅ Unified script for both sender and receiver roles
- 🔌 Uses `ncat` for data transmission
- 🔍 Collects files, command output, memory images, or disk images
- ⚙️ Automates tool installation (like `ncat`) if missing
- 📦 Easy to deploy in trusted environments

---

## ⚙️ Requirements

- **Bash** or compatible shell
- **ncat** (from the Nmap project) — the script installs it if not present
- Network access between sender and receiver machines

---

## 🧪 Installation

Clone the repository and make the script executable:

```bash
git clone https://github.com/Akashthakar/Remote-Evidence-Collector.git
cd Remote-Evidence-Collector
chmod +x collector.sh
````

---

## 🚀 Usage

Run the unified script on **both machines**, and it will prompt you to select a role:

```bash
./collector.sh
```

You will be asked:

* Whether this machine is the **Sender** or the **Receiver**
* IP address and port (for Sender to connect)
* What type of evidence to send (files, command output, memory, disk image)
* Where to store the evidence on the receiver side

📝 **Example Flow:**

### 🔹 On the Receiver (Collector)

```bash
./collector.sh
```

* Select **Receiver**
* Enter port to listen on (e.g., 4444)
* Enter destination file name to save received data

### 🔹 On the Sender (Infected system)

```bash
./collector.sh
```

* Select **Sender**
* Enter receiver's IP and port
* Select type of data to send (e.g., file, memory image, command output)
* Provide source path or command

The script handles the rest.

---

## 🔐 Security Considerations

⚠️ This script is intended for use in **controlled or trusted environments**. It does **not** include built-in:

* Encryption
* Authentication
* Data integrity checks

For secure use:

* Consider running it over SSH or a VPN
* Use encrypted storage for received evidence
* Hash collected files before and after transfer

---

## 📁 File Structure

```
collector.sh         # Unified script (sender + receiver)
README.md            # Project documentation
```

Older versions with separate `sender.sh` and `receiver.sh` are available under the [legacy branch](https://github.com/Akashthakar/Remote-Evidence-Collector/tree/legacy-v1) or via [Releases](https://github.com/Akashthakar/Remote-Evidence-Collector/releases).

---

## 📦 Releases

➡️ [Download Latest Release](https://github.com/Akashthakar/Remote-Evidence-Collector/releases/latest)

➡️ [View Legacy v1.0.0 Release](https://github.com/Akashthakar/Remote-Evidence-Collector/releases/tag/v1.0.0)

---

## 🧑‍💻 Contributing

Pull requests are welcome for:

* Improving security (e.g., adding encryption)
* Supporting more OS environments
* Expanding evidence types
* Logging, error handling, etc.

---

## 🛠 License

This project is open source under the [MIT License](LICENSE).

---

## 👤 Author

**Akash Thakar**
[GitHub Profile](https://github.com/Akashthakar)

---
