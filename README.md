# Customized Dropbear SSH Server

This project builds a modified version of the Dropbear SSH server with enhanced features for CTF/lab environments. It allows for a hardcoded password and runs in the current user's context.

## Key Features

- Docker-based build process for easy compilation and output
- Hardcoded password support (easily changeable)
- In-memory host key generation (optional)
- Process name obfuscation
- Modified PID and key folder locations (default: /tmp, changeable via flags)
- Designed for scenarios where the current user's password is unknown, but a full TTY shell is needed
- Run in the user context. If you run as "root" you login with root and your hardcoded password (etc)

## New Features and Changes

1. **In-Memory Host Keys**: Host keys can now be generated and stored in memory, avoiding disk writes. This feature is enabled by default and can be disabled with the `-M` flag.

2. **Process Name Obfuscation**: The Dropbear process name is now changed to match the binary name, making it less conspicuous in process lists.

3. **Hardcoded Password**: A hardcoded password can be set, allowing for predetermined access without knowing the system user's password.

4. **Modified Authentication**: The authentication process has been updated to check against the hardcoded password first, then fall back to system authentication if that fails.

5. **Removed Utmp/Wtmp Logging**: Login record writing has been disabled to reduce traces of the SSH session. As well as syslog disabled.

6. **Default Host Key Generation**: Host key generation is now enabled by default. This is needed for the in memory keys. Use the `-R` flag to disable this feature.

## Building the Server

1. Modify `password.txt` with your desired hardcoded password.

2. Build the Docker image:

```bash
docker build -t dropbear64 .
```

3. Run the container to compile Dropbear:


```bash
docker run -v ${PWD}/output:/output -it dropbear64
```

4. The compiled Dropbear binary will be in the `output` folder.

## Usage

Run the compiled Dropbear binary. By default, it will:

- Generate in-memory host keys
- Use the hardcoded password from `password.txt`
- Hide the process name

To disable in-memory host keys and use disk-based keys, use the `-M` flag.

## Security Notice

This modified version of Dropbear is intended for CTF and lab environments only. It includes features that may compromise security and should not be used in production environments.

## Inspiration

These modifications were inspired by the BlackEnergy SSH backdoor, as detailed in [this article](https://www.welivesecurity.com/2016/01/03/blackenergy-sshbeardoor-details-2015-attacks-ukrainian-news-media-electric-industry/).

## Related Projects

For similar tools, check out [pentestkoala](https://github.com/mrschyte/pentestkoala).
