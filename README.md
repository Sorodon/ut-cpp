# Programming in C++

> [!IMPORTANT]  
> This repo will go hidden once the course starts (as it'll hold my assignments)

## Reasoning

VS Code can not be considered open software. The source is MIT licenced, but relevant extensions only work with Microsoft binaries.  
Therefore a container isolates this questionable piece of software from the rest of the system, making it easier to remove it later on.  
To clarify once more: This is not a dev container accesssible through VS Code. This is a container containing VS Code.

## Setup

1. Install podman (or Docker for whatever reason and change the script accordingly)
2. Build image with `podman build -t cppcourse .`
    - If you don't like the vim extension disable it before building
3. Adapt the `vscode.sh` script to contain your assignments path  
    If your folder structure looks like this:  
    ```
    cppcourse/
    ├── assignments/
    │   ├── 00/
    │   │   └── ...
    │   ├── 01/
    │   │   └── ...
    │   └── ...
    └── container/
        ├── Dockerfile
        └── vscode.sh
    ```
    Set the path to `../assignments/`

## Usage

Run the `vscode.sh` script to start the container  
Provide the assignment to work on as parameter, e.g. `vscode.sh 01`
Providing `reset` as parameter (e.g. `vscode.sh reset`) deletes the user config, resulting in a new Code setup
Providing no parameter calls the directory defined for assignments
