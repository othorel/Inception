# 🐳 Inception

- A secure and modular **Docker-based infrastructure** using **Docker Compose** – 42 Project

<p align="center">
  <img src="https://raw.githubusercontent.com/your-username/inception/main/assets/inception-diagram.png" alt="Inception Diagram" />
</p>

---

## 🧠 About

**Inception** is a system administration project from the 42 curriculum, where the goal is to set up a secure and scalable **web infrastructure** entirely via **Docker** and **Docker Compose**.  
It focuses on containerization, security, service orchestration, and automation.

This project introduces best practices in **DevOps** and **web hosting**, all deployed on a local virtual machine running **Debian**.

---

## 🛠️ Services

### 🧱 Mandatory

- 🐬 **MariaDB**  
  - Secure root password  
  - Initializes and manages the WordPress database  
  - Uses a volume for persistent storage

- 🌐 **Nginx**  
  - Serves as a reverse proxy  
  - HTTPS via self-signed TLS certificates  
  - Listens only on port 443

- 📝 **WordPress (PHP-FPM)**  
  - Installed and configured at runtime  
  - Connects to MariaDB  
  - Uses environment variables  
  - Optional Redis integration  
  - Persistent content via volume

### ✨ Bonus

- ⚡ **Redis**  
  - Acts as an object cache for WordPress  
  - Improves performance

- 🏗️ **Static Site**  
  - Separate Nginx container  
  - Serves static HTML/CSS content

- 🗂️ **Adminer**  
  - Simple DB management UI  
  - Web interface to interact with MariaDB

- 📂 **FTP Server (vsftpd)**  
  - Secure FTP access to WordPress files  
  - Encrypted via TLS

- 📊 **cAdvisor**  
  - Real-time monitoring of containers  
  - Access via `localhost:8080`

---

## ⚙️ Tech Stack

- Docker & Docker Compose  
- Debian 11 (bullseye)  
- MariaDB, PHP-FPM, Nginx  
- Redis, Adminer, vsftpd  
- cAdvisor, OpenSSL

---

## 🚀 Getting Started

### 🔧 Prerequisites

- Docker  
- Docker Compose  
- Make  
- Linux VM (e.g., Debian)

### 🔨 Installation

```bash
git clone https://github.com/your-username/inception.git
cd inception
make
```
---
