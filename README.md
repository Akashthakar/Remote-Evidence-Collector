# Remote-Evidence-Collector
Lightweight Bash scripts for remote evidence collection. It includes sender and receiver scripts for secure data transfer during incident response or forensic investigations.

## Features
- Lightweight and dependency-minimal (requires only `ncat`)
- Works over TCP (with optional SSL)
- Designed for internal or trusted network usage
- Simple to automate and integrate into incident response pipelines

## Requirements

- `ncat` (from the Nmap project) installed on both systems (Sctipt will do it on its own)
- Bash or compatible shell
- Network connectivity between sender and receiver

## Installation of Script
To use this script, follow these steps:

### 1. Clone the Repository and make it executable
Clone this repository to your local machine using Git:
<pre>git clone https://github.com/Akashthakar/remote-evidence-collector.git
cd remote-evidence-collector</pre>
Change the permissions of the script to make it executable:
<pre> chmod +x * </pre>

## Usage
Run the script to start collection evidence remotely 
### 1. On the Receiver (Collector) Machine
- Run the `receiver.sh` to start listening for incoming data:
- Give port number to listen
- Select what to receive?
- Give file name to store data

### 2. On the Sender (Infected) Machine
- Run the `sender.sh` to start listening for incoming data:
- Give Listening Machine's IP
- Give port number
- Select what to transfer? 
- According to that give command or file or image source or memory image file

## Security Notice
These scripts are designed for use in trusted or controlled environments. They do not include encryption, authentication, or integrity checks out of the box.
