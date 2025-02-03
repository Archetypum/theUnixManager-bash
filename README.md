# theUnixManager (bash)
![theUnixManagerEdited](https://github.com/user-attachments/assets/6c0b3fbc-1d09-4d35-9dde-33b22a468c45)

theUnixManager - ultimate package manager && init system handling library made by Archetypum
that simplifies interaction with UNIX systems and creation of system-related bash scripts. 

 ## Installation of theUnixManager-unstable (as root):

```bash
git clone https://github.com/Archetypum/theUnixManager-bash
```

```bash
cd theUnixManager-bash
```

Copy it to your desired location:

```bash
cp the_unix_manager.sh /usr/bin/the_unix_manager.sh  # we recommend using this path
```

And then use it in your bash scripts:

```bash
source /usr/bin/the_unix_manager.sh

DISTRO=$(get_user_distro)
INIT_SYSTEM=$(get_init_system)

package_handling "$DISTRO" "install" "vim"
init_system_handling "$INIT_SYSTEM" "ssh" "start"
```

## License

theUnixManager uses GNU Lesser General Public License V3. 

More information in:

- _LICENSE.md_
- _https://www.fsf.org_
- _https://www.gnu.org_

![gnu](https://github.com/user-attachments/assets/66935a97-374f-4dbc-9f1c-428070fda139)
