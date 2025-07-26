# fzsys

fzsys is a Bash-based interactive system information menu for Linux, powered by [fzf](https://github.com/junegunn/fzf).  
It lets you browse and run common system info commands, view live stats, search logs/files/processes, and more—all from your terminal.

## Features

- System summary (CPU, memory, disk, uptime)
- View CPU, memory, disk, partitions, network, open ports, processes, services, users, logs, hardware info
- Live updating views (watch top processes, disk usage, network)
- Search for processes, logs, or files
- Colorized output for easier reading
- Help and easy exit

## Requirements

- Bash
- [fzf](https://github.com/junegunn/fzf)
- Standard Linux utilities (lscpu, free, df, lsblk, ip, ss, ps, systemctl, who, journalctl, lshw, watch, grep, find)

## Installation

### Automatic Installation

1. Clone this repository:
   ```sh
   git clone https://github.com/cmerrill00/fzsys.git
   cd fzsys
   ```
2. Run the install script:
   ```sh
   bash install.sh
   ```
   This will:
   - Install `fzsys.sh` as `fzsys` in `/usr/local/bin` (requires sudo)
   - Warn you if `fzf` is not installed

3. Run fzsys from anywhere:
   ```sh
   fzsys
   ```

### Manual Installation

1. Make the script executable:
   ```sh
   chmod +x fzsys.sh
   ```
2. Copy `fzsys.sh` to a directory in your `$PATH` (e.g., `/usr/local/bin`):
   ```sh
   sudo cp fzsys.sh /usr/local/bin/fzsys
   ```
3. Ensure [fzf](https://github.com/junegunn/fzf) is installed:
   ```sh
   fzf --version
   ```
   If not installed, follow instructions on the [fzf GitHub page](https://github.com/junegunn/fzf).

4. Run fzsys:
   ```sh
   fzsys
   ```

## Usage

Run `fzsys` and select an option from the menu.  
Use the search option to find processes, logs, or files by keyword.  
Use the watch options for live updating views.

## License

MIT

---

**Contributions welcome!**